import Quickshell.Services.Pipewire
import QtQuick
import QtQuick.Layouts

Rectangle {
    id: root
    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight
    color: "transparent"
    property var node: Pipewire.defaultAudioSink
    Behavior on implicitWidth {
        NumberAnimation {
            duration: 150
            easing.type: Easing.InOutQuad
        }
    }
    PwObjectTracker {
        objects: [root.node]
    }
    RowLayout {
        id: row
        anchors {
            fill: parent
        }
        Text {
            text: root.node.audio.muted ? "󰝟" : root.node.audio.volume > 0.6 ? "󰕾" : root.node.audio.volume > 0.3 ? "󰖀" : "󰕿"
            color: root.node.audio.muted ? "#52263e" : "#ac3231"
            font.family: "BigBlueTermPlusNerdFont"
            font.pointSize: 15
        }
        Text {
            visible: root.node.audio.muted ? false : true
            text: parseInt(root.node.audio.volume * 100) + "%"
            color: "#52263e"
            font.family: "BigBlueTermPlusNerdFont"
            Behavior on visible {
                NumberAnimation {
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
    MouseArea {
        anchors {
            fill: parent
        }
        onClicked: root.node.audio.muted = !root.node.audio.muted

        cursorShape: Qt.PointingHandCursor
        onWheel: e => {
            e.accepted = true;
            let delta = e.angleDelta.y / 120;
            let newVolume = root.node.audio.volume + delta * 0.05;

            newVolume = Math.max(0, Math.min(1, newVolume));

            root.node.audio.volume = newVolume;
        }
    }
}
