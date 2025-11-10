pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import QtQuick.Effects
import QtQuick.Controls.Fusion
import Quickshell.Wayland
import Quickshell
import Quickshell.Io
import "." as Lock
import "../widgets"

Rectangle {
    id: root
    required property Lock.Context context

    color: "#0d0d14"
    anchors.fill: parent
    opacity: 0
    visible: true

    Behavior on opacity {
        NumberAnimation {
            duration: 250
            easing.type: Easing.Linear
        }
    }

    Component.onCompleted: {
        root.opacity = 1;
    }

    Image {
        id: bgImage
        anchors.fill: parent
        source: "../assets/lockscreen.png"
        fillMode: Image.PreserveAspectCrop
        opacity: 0
        smooth: true
        cache: false

        transformOrigin: Item.Center
        scale: 1.0

        Behavior on opacity {
            NumberAnimation {
                duration: 250
                easing.type: Easing.Linear
            }
        }

        PropertyAnimation {
            target: bgImage
            property: "scale"
            from: 1.0
            to: 4.0
            duration: 240000
            running: true
            easing.type: Easing.Linear
        }

        Component.onCompleted: {
            bgImage.opacity = 1;
        }
    }
    Time {
        size: 100
        anchors.centerIn: parent
    }

    RowLayout {
        id: passwordRow
        anchors.centerIn: parent
        anchors.verticalCenterOffset: 100
        spacing: 42
        opacity: (passwordBox.enabled && passwordBox.text.length > 0) ? 1 : 0
        visible: true
        enabled: passwordBox.enabled && passwordBox.text.length > 0

        Behavior on opacity {
            NumberAnimation {
                duration: 300
                easing.type: Easing.InOutQuad
            }
        }

        Repeater {
            model: 6
            delegate: Rectangle {
                id: r
                required property var modelData

                color: (root.context.showFailure || passwordBox.length > r.modelData) ? "#ac3231" : "#0d0d14"
                radius: width / 2
                implicitWidth: 36
                implicitHeight: 36
                Image {
                    anchors.fill: parent
                    smooth: false
                    source: "../assets/workspace-button.png"
                }


                Behavior on color {
                    ColorAnimation {
                        duration: 100
                        easing.type: Easing.InOutQuad
                    }
                }
            }
        }
    }
    SequentialAnimation {
        id: animExit
        running: false

        NumberAnimation {
            target: root
            property: "opacity"
            from: 1
            to: 0
            duration: 250
            easing.type: Easing.Linear
        }

        onFinished: () => root.context.unlocked()
    }
    TextField {
        id: passwordBox

        implicitWidth: 400
        font.pointSize: 50
        color: "transparent"
        cursorVisible: false
        background: Rectangle {
            color: "transparent"
        }

        focus: true
        enabled: !root.context.unlockInProgress
        opacity: 0
        echoMode: TextInput.Password
        inputMethodHints: Qt.ImhSensitiveData

        onTextChanged: () => {
            if (text != "") {
                root.context.showFailure = false;
            }
        }

        onAccepted: () => {
            root.context.currentText = text;
            root.context.tryUnlock();
        }

        Connections {
            target: root.context

            function onUnlockInProgressChanged() {
                if (root.context.unlockInProgress == false) {
                    passwordBox.text = "";
                }
            }

            function onPamSuccess() {
                animExit.running = true;
            }
        }
    }

    // Button {
    //     text: "Exit"
    //     onClicked: root.context.unlocked()
    // }
}
