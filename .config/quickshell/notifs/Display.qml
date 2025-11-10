// This is how the notification looks
import QtQuick
import QtQuick.Layouts
import Quickshell.Services.Notifications
import "../widgets"

Item {
    id: root

    required property Notification notif

    implicitWidth: 392
    implicitHeight: layout.height

    ColumnLayout {
        id: layout

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        spacing: 0

        Rectangle {
            id: bannerRect
            color: "#0d0d14"
            Layout.fillWidth: true
            implicitHeight: textColumn.implicitHeight + 16

            Border {}
            RowLayout {
                id: textColumn
                anchors {
                    fill: parent
                    margins: 8
                }

                spacing: 8

                Image {
                    id: appIcon

                    readonly property var validExts: [".png", ".jpg", ".jpeg", ".svg", ".webp", ".ico"]
                    function hasValidExt(path) {
                        if (!path || typeof path !== "string") {
                            return false;

                        }
                        return validExts.some(ext => path.toLowerCase().endsWith(ext));
                    }

                    property string iconSource: {
                        if (!root.notif)
                            return "";

                        if (hasValidExt(root.notif.image))
                            return root.notif.image;

                        if (hasValidExt(root.notif.appIcon))
                            return root.notif.appIcon;

                        return "";
                    }

                    source: iconSource
                    visible: iconSource !== ""
                    Layout.preferredWidth: visible ? 64 : 0
                    Layout.preferredHeight: visible ? 64 : 0
                    fillMode: Image.PreserveAspectFit
                }

                ColumnLayout {
                    Layout.fillWidth: true
                    spacing: 4

                    Text {
                        text: root.notif ? root.notif.summary : ""
                        font.family: "BigBlueTermPlusNerdFont"
                        wrapMode: Text.Wrap
                        font.pointSize: 14
                        font.bold: true
                        color: "#ac3231"
                        Layout.fillWidth: true
                    }

                    Text {
                        text: root.notif ? root.notif.body : ""
                        font.family: "BigBlueTermPlusNerdFont"
                        wrapMode: Text.Wrap
                        font.pointSize: 11
                        color: "#52263e"
                        Layout.fillWidth: true
                    }
                }
            }
        }
    }
}
