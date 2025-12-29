import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtQuick.Dialogs 1.3

import Theme 1.0
import QFlipper 1.0

Rectangle {
    id: root
    color: "transparent"

    property string profileName: ""
    property string profileDescription: ""
    property string avatarPath: ""

    signal settingsSaved()

    Component.onCompleted: {
        loadSettings()
    }

    function loadSettings() {
        // Load from QSettings via backend
        Backend.profileSettings.loadProfile(function(profile) {
            profileName = profile.name || "Bad-Antics User"
            profileDescription = profile.description || "Flipper Zero Device Manager"
            avatarPath = profile.avatarPath || ""
        })
    }

    function saveSettings() {
        Backend.profileSettings.saveProfile({
            name: profileName,
            description: profileDescription,
            avatarPath: avatarPath
        })
        settingsSaved()
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 15

        // Profile Header
        Rectangle {
            Layout.fillWidth: true
            height: 100
            color: Theme.palette.bg0
            radius: 8

            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                spacing: 20

                // Avatar Display
                Rectangle {
                    width: 70
                    height: 70
                    radius: 35
                    color: Theme.palette.bg2
                    border.color: Theme.palette.fg1
                    border.width: 2

                    Image {
                        anchors.fill: parent
                        anchors.margins: 2
                        source: avatarPath ? ("file:///" + avatarPath) : "qrc:/assets/gfx/symbolic/default-avatar.svg"
                        sourceSize: Qt.size(width, height)
                        fillMode: Image.PreserveAspectCrop
                        smooth: true
                    }

                    MouseArea {
                        anchors.fill: parent
                        cursorShape: Qt.PointingHandCursor
                        onClicked: fileDialog.open()
                    }
                }

                // Profile Info
                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 5

                    TextLabel {
                        text: profileName
                        font.pixelSize: 16
                        font.bold: true
                        color: Theme.palette.fg1
                    }

                    TextLabel {
                        text: profileDescription
                        font.pixelSize: 12
                        color: Theme.palette.fg2
                        elide: Text.ElideRight
                    }
                }

                Item { Layout.fillWidth: true }
            }
        }

        // Profile Name Input
        ColumnLayout {
            spacing: 5

            TextLabel {
                text: qsTr("Profile Name")
                color: Theme.palette.fg1
                font.bold: true
            }

            TextBox {
                Layout.fillWidth: true
                placeholderText: qsTr("Enter your profile name")
                text: profileName
                onTextChanged: profileName = text
            }
        }

        // Profile Description Input
        ColumnLayout {
            spacing: 5

            TextLabel {
                text: qsTr("Profile Description")
                color: Theme.palette.fg1
                font.bold: true
            }

            Rectangle {
                Layout.fillWidth: true
                height: 60
                color: Theme.palette.bg0
                border.color: Theme.palette.fg3
                border.width: 1
                radius: 4

                TextEdit {
                    anchors.fill: parent
                    anchors.margins: 8
                    color: Theme.palette.fg1
                    selectionColor: Theme.palette.bg2
                    font.pixelSize: 12
                    wrapMode: TextEdit.Wrap
                    text: profileDescription
                    onTextChanged: profileDescription = text

                    TextMetrics {
                        id: textMetrics
                        font: parent.font
                        text: parent.text
                    }
                }
            }
        }

        // Avatar Section
        ColumnLayout {
            spacing: 10

            TextLabel {
                text: qsTr("Avatar")
                color: Theme.palette.fg1
                font.bold: true
            }

            TextLabel {
                text: avatarPath ? avatarPath.split('/').pop() : qsTr("No avatar selected")
                color: Theme.palette.fg2
                font.pixelSize: 11
            }

            RowLayout {
                spacing: 10

                SmallButton {
                    text: qsTr("Choose Avatar")
                    onClicked: fileDialog.open()
                }

                SmallButton {
                    text: qsTr("Remove Avatar")
                    enabled: avatarPath.length > 0
                    onClicked: {
                        avatarPath = ""
                    }
                }
            }
        }

        Item { Layout.fillHeight: true }

        // Action Buttons
        RowLayout {
            spacing: 10
            Layout.alignment: Qt.AlignRight

            SmallButton {
                text: qsTr("Reset")
                onClicked: loadSettings()
            }

            MainButton {
                text: qsTr("Save Settings")
                onClicked: saveSettings()
            }
        }
    }

    FileDialog {
        id: fileDialog
        title: qsTr("Choose Avatar Image")
        folder: shortcuts.pictures
        nameFilters: [
            qsTr("Image Files (*.png *.jpg *.jpeg *.bmp)"),
            qsTr("All Files (*)")
        ]
        onAccepted: {
            var path = fileUrl.toString().replace("file:///", "").replace(/\//g, "\\")
            avatarPath = path
        }
    }
}
