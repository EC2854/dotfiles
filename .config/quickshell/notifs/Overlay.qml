pragma ComponentBehavior: Bound

import QtQuick
import Quickshell
import Quickshell.Wayland
import Quickshell.Services.Notifications
import "."

PanelWindow {
    id: root

    required property var bar
    property list<Notification> notifs

    WlrLayershell.namespace: "shell:notifications"
    exclusionMode: ExclusionMode.Ignore
    color: "transparent"

    anchors {
        left: true
        top: true
        bottom: true
        right: true
    }

    NotificationServer {
        actionsSupported: true

        onNotification: notif => {
            notif.tracked = true;
            root.notifs = [...root.notifs, notif];
        }
    }

    visible: stack.children.length != 0
    mask: Region {
        item: stack
    }

    ListView {
        id: stack

        model: ScriptModel {
            values: [...root.notifs]
        }
        anchors.right: parent.right
        y: root.bar.height + 12
        implicitWidth: 400
        implicitHeight: children.reduce((h, c) => h + c.height, 0)
        interactive: false
        spacing: 16
        verticalLayoutDirection: ListView.BottomToTop

        move: Transition {
            NumberAnimation {
                property: "y"
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        remove: Transition {
            NumberAnimation {
                property: "y"
                duration: 200
                easing.type: Easing.OutCubic
            }
        }

        delegate: Notif {
            required property Notification modelData
            notif: modelData

            onDismissed: {
                if (notif) {
                    notif.dismiss();
                }
                root.notifs = root.notifs.filter(n => n !== notif);
            }
        }
    }
}
