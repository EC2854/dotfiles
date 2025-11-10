import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland
import "../widgets"
import "./mpris"

PanelWindow {
    id: root

    property var modelData

    WlrLayershell.namespace: "shell:bar"
    anchors {
        top: true
        left: true
        right: true
    }
    exclusiveZone: 42
    implicitHeight: 42
    color: "transparent"
    mask: barRegion

    Region {
        id: barRegion
        width: bar.width
        height: bar.height
    }

    Rectangle {
        id: bar

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            leftMargin: 8
            topMargin: 8
            rightMargin: 8
        }

        implicitHeight: 28
        color: "transparent"

        Rectangle {
            anchors {
                top: parent.top
                bottom: parent.bottom
                left: parent.left
            }
            implicitWidth: left.implicitWidth + 24
            implicitHeight: left.implicitHeight
            color: "#0d0d14"

            Border {}

            RowLayout {
                id: left
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }

                Workspaces {
                    bar: root
                }
            }
        }
        Rectangle {
            anchors {
                horizontalCenter: parent.horizontalCenter
                top: parent.top
                bottom: parent.bottom
            }
            implicitWidth: center.implicitWidth + 24
            implicitHeight: center.implicitHeight
            color: "#0d0d14"

            visible: MprisController.activeTrack?.title !== ""
            Border {}
            RowLayout {
                id: center
                clip: true
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }
                MprisWidget {}
            }
            Behavior on visible {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }

            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }

        Rectangle {
            id: right
            anchors {
                top: parent.top
                bottom: parent.bottom
                right: parent.right
            }
            implicitWidth: time.implicitWidth + 24
            implicitHeight: time.implicitHeight
            color: "#0d0d14"
            Border {}

            RowLayout {
                id: time
                clip: true
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }

                Time {
                    id: timewidget
                    size: 14
                    showDate: false
                }
            }
            MouseArea {
                z: 10
                anchors {
                    fill: parent
                }
                hoverEnabled: true
                onEntered: timewidget.showDate = true
                onExited: timewidget.showDate = false
            }
            Behavior on implicitWidth {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }

        }
        Rectangle {
            Border {}
            implicitWidth: tray.implicitWidth + 24
            implicitHeight: tray.implicitHeight
            color: "#0d0d14"

            anchors {
                top: parent.top
                bottom: parent.bottom
                right: right.left
                rightMargin: 16
            }

            RowLayout {
                id: tray
                clip: true
                spacing: 12
                anchors {
                    fill: parent
                    leftMargin: 12
                    rightMargin: 12
                }
                Volume {}
                Mic {}
                Power {}
            }
        }
    }
}
