#include "profilesettings.h"
#include <QJsonObject>
#include <QStandardPaths>
#include <QCoreApplication>

ProfileSettings::ProfileSettings(QObject *parent)
    : QObject(parent),
      m_settings(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation) + "/bad-antics-flipper.conf",
                 QSettings::IniFormat, this)
{
    // Ensure default values exist
    if (!m_settings.contains(PROFILE_NAME_KEY)) {
        m_settings.setValue(PROFILE_NAME_KEY, "Bad-Antics User");
    }
    if (!m_settings.contains(PROFILE_DESC_KEY)) {
        m_settings.setValue(PROFILE_DESC_KEY, "Flipper Zero Device Manager");
    }
}

void ProfileSettings::loadProfile(std::function<void(const QJsonObject&)> callback)
{
    QJsonObject profile;
    profile["name"] = m_settings.value(PROFILE_NAME_KEY, "Bad-Antics User").toString();
    profile["description"] = m_settings.value(PROFILE_DESC_KEY, "Flipper Zero Device Manager").toString();
    profile["avatarPath"] = m_settings.value(AVATAR_PATH_KEY, "").toString();

    if (callback) {
        callback(profile);
    }
}

void ProfileSettings::saveProfile(const QJsonObject &profile)
{
    if (profile.contains("name")) {
        m_settings.setValue(PROFILE_NAME_KEY, profile["name"].toString());
    }
    if (profile.contains("description")) {
        m_settings.setValue(PROFILE_DESC_KEY, profile["description"].toString());
    }
    if (profile.contains("avatarPath")) {
        m_settings.setValue(AVATAR_PATH_KEY, profile["avatarPath"].toString());
    }

    m_settings.sync();
    emit profileChanged();
}

QString ProfileSettings::getProfileName() const
{
    return m_settings.value(PROFILE_NAME_KEY, "Bad-Antics User").toString();
}

QString ProfileSettings::getProfileDescription() const
{
    return m_settings.value(PROFILE_DESC_KEY, "Flipper Zero Device Manager").toString();
}

QString ProfileSettings::getAvatarPath() const
{
    return m_settings.value(AVATAR_PATH_KEY, "").toString();
}
