from flask import Flask, render_template, request, jsonify, session
from flask_bootstrap import Bootstrap
import serial
import requests
import time
import logging
from functools import wraps
import os

app = Flask(__name__)
app.secret_key = os.getenv('SECRET_KEY', 'change_this_secret_key_in_production')
Bootstrap(app)

# Logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# === Configuration (override via config.py or environment) ===
FLIPPER_PORT = os.getenv('FLIPPER_PORT', '/dev/ttyACM0')  # Linux/Mac; Windows: 'COM3'
FLIPPER_BAUD = 230400
FLIPPER_TIMEOUT = 2

PINEAPPLE_URL = os.getenv('PINEAPPLE_URL', 'http://172.16.42.1:1471')
PINEAPPLE_USERNAME = os.getenv('PINEAPPLE_USER', 'root')
PINEAPPLE_PASSWORD = os.getenv('PINEAPPLE_PASS', 'your_password_here')

# Optional: load local config if exists
if os.path.exists('config.py'):
    app.config.from_pyfile('config.py')

# Flipper connection state
flipper_connected = False
flipper_ser = None

def connect_flipper():
    global flipper_ser, flipper_connected
    try:
        if flipper_ser and flipper_ser.is_open:
            flipper_ser.close()
        flipper_ser = serial.Serial(FLIPPER_PORT, FLIPPER_BAUD, timeout=FLIPPER_TIMEOUT)
        flipper_connected = True
        logger.info("Flipper Zero connected")
        return True
    except Exception as e:
        logger.error(f"Flipper connection failed: {e}")
        flipper_connected = False
        return False

connect_flipper()

def with_flipper(func):
    @wraps(func)
    def wrapper(*args, **kwargs):
        if not flipper_connected:
            if not connect_flipper():
                return jsonify({'error': 'Flipper Zero not connected'})
        try:
            return func(*args, **kwargs)
        except Exception as e:
            logger.error(f"Flipper error: {e}")
            connect_flipper()
            return jsonify({'error': str(e)})
    return wrapper

@with_flipper
def send_flipper_command(command):
    try:
        flipper_ser.reset_input_buffer()
        flipper_ser.write((command + '\r\n').encode())
        time.sleep(0.6)
        response = flipper_ser.read(flipper_ser.in_waiting).decode(errors='ignore').strip()
        return response or 'Command sent.'
    except Exception:
        raise

def get_pineapple_token():
    if 'pineapple_token' in session:
        return session['pineapple_token']
    try:
        resp = requests.post(f'{PINEAPPLE_URL}/api/login',
                             json={'username': PINEAPPLE_USERNAME, 'password': PINEAPPLE_PASSWORD},
                             timeout=5)
        if resp.status_code == 200 and 'token' in resp.json():
            session['pineapple_token'] = resp.json()['token']
            return session['pineapple_token']
    except Exception as e:
        logger.error(f"Pineapple login failed: {e}")
    return None

def pineapple_api_call(endpoint, method='GET', data=None, timeout=10):
    token = get_pineapple_token()
    if not token:
        return {'error': 'Pineapple authentication failed'}
    headers = {'Authorization': f'Bearer {token}'}
    url = f'{PINEAPPLE_URL}{endpoint}'
    try:
        resp = requests.request(method, url, headers=headers, json=data, timeout=timeout)
        return resp.json() if resp.status_code == 200 else {'error': f'{resp.status_code}: {resp.text}'}
    except requests.Timeout:
        return {'error': 'Pineapple request timed out'}
    except requests.ConnectionError:
        return {'error': 'Cannot reach WiFi Pineapple'}
    except Exception as e:
        return {'error': str(e)}

# Routes
@app.route('/')
def home():
    return render_template('home.html')

@app.route('/flipper')
def flipper():
    return render_template('flipper.html', connected=flipper_connected)

@app.route('/pineapple')
def pineapple():
    return render_template('pineapple.html', connected=bool(get_pineapple_token()))

@app.route('/flipper_monitor')
def flipper_monitor():
    if not flipper_connected:
        return jsonify({'error': 'Not connected', 'connected': False})
    return jsonify({
        'info': send_flipper_command('info device'),
        'uptime': send_flipper_command('uptime'),
        'memory': send_flipper_command('free'),
        'connected': True
    })

@app.route('/flipper_command', methods=['POST'])
def flipper_command():
    cmd = request.form.get('command', '').strip()
    if not cmd:
        return jsonify({'error': 'Empty command'})
    return jsonify({'result': send_flipper_command(cmd)})

@app.route('/flipper_subghz_tx', methods=['POST'])
def flipper_subghz_tx():
    data = request.get_json()
    action = data.get('action')
    cmd = ""

    if action == 'carrier':
        cmd = 'subghz tx carrier 433920000 0'
    elif action == 'static':
        cmd = 'subghz tx 123456 433920000 100 10 0'
    elif action == 'custom_key':
        key = data.get('key', '').strip().upper()
        if not key or not all(c in '0123456789ABCDEF' for c in key):
            return jsonify({'error': 'Invalid hex key'})
        cmd = f"subghz tx {key} {data.get('freq', '433920000')} {data.get('te', '100')} {data.get('repeat', '10')} 0"
    elif action == 'from_file':
        path = data.get('path', '').strip()
        if not path.startswith('/'):
            return jsonify({'error': 'Invalid file path'})
        cmd = f"subghz tx_from_file {path} {data.get('repeat', '1')} 0"
    elif action == 'raw':
        raw = data.get('raw_data', '').strip()
        if not raw:
            return jsonify({'error': 'Raw data required'})
        cmd = f"subghz raw tx {data.get('freq', '433920000')} {raw}"
    else:
        return jsonify({'error': 'Unknown action'})

    return jsonify({'result': send_flipper_command(cmd)})

@app.route('/pineapple_status')
def pineapple_status():
    return jsonify(pineapple_api_call('/api/status'))

@app.route('/pineapple_logs')
def pineapple_logs():
    return jsonify(pineapple_api_call('/api/pineap/log'))

@app.route('/pineapple_notifications')
def pineapple_notifications():
    return jsonify(pineapple_api_call('/api/notifications'))

@app.route('/pineapple_settings', methods=['POST'])
def pineapple_settings():
    return jsonify(pineapple_api_call('/api/pineap/settings', 'PUT', request.json))

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)