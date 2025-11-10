import QtQuick
import QtQuick.Layouts
import Quickshell.Services.UPower

Rectangle {
    id: root

    readonly property var chargeState: UPower.displayDevice.state
    readonly property bool isCharging: chargeState == UPowerDeviceState.Charging
    readonly property bool isPluggedIn: isCharging || chargeState == UPowerDeviceState.PendingCharge
    readonly property bool isCharged: chargeState == UPowerDeviceState.FullyCharged
    readonly property real percentage: UPower.displayDevice.percentage
    readonly property bool isLow: percentage <= 0.20

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight
    color: "transparent"
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }
    RowLayout {
        id: row
        Text {
            id: batIcon
            font.family: "BigBlueTermPlusNerdFont"
            text: "󰂎"
            color: "#ac3231"
            font.pointSize: 15
            Rectangle {
                id: progressBar
                color: "#0d0d14"
                z: -1
                Rectangle {
                    anchors.bottom: parent.bottom
                    anchors.left: parent.left
                    anchors.right: parent.right
                    height: root.percentage * parent.height
                    color: root.isCharging ? "#2abf90" : (root.isLow ? "#ebd99c" : "#52263e")
                }
                anchors {
                    fill: parent
                    leftMargin: 3
                    rightMargin: 3
                    bottomMargin: 3
                    topMargin: 3
                }
            }
            visible: root.isCharged ? false : true
            Behavior on visible {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Text {
            id: chargedIcon
            text: ""
            color: "#ac3231"
            font.family: "BigBlueTermPlusNerdFont"
            visible: root.isCharged ? true : false

            Behavior on visible {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
        Text {
            id: batPrct
            text: (root.percentage * 100) + "%"
            color: "#52263e"
            font.family: "BigBlueTermPlusNerdFont"
            visible: root.isCharged ? false : true
            Behavior on visible {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
