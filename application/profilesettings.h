#ifndef PROFILESETTINGS_H
#define PROFILESETTINGS_H

#include <QObject>
#include <QSettings>
#include <QJsonObject>
#include <functional>

class ProfileSettings : public QObject {
    Q_OBJECT

public:
    explicit ProfileSettings(QObject *parent = nullptr);
    ~ProfileSettings() = default;

    Q_INVOKABLE void loadProfile(std::function<void(const QJsonObject&)> callback);
    Q_INVOKABLE void saveProfile(const QJsonObject &profile);
    Q_INVOKABLE QString getProfileName() const;
    Q_INVOKABLE QString getProfileDescription() const;
    Q_INVOKABLE QString getAvatarPath() const;

signals:
    void profileChanged();

private:
    QSettings m_settings;

    static constexpr const char* PROFILE_NAME_KEY = "profile/name";
    static constexpr const char* PROFILE_DESC_KEY = "profile/description";
    static constexpr const char* AVATAR_PATH_KEY = "profile/avatarPath";
};

#endif // PROFILESETTINGS_H
