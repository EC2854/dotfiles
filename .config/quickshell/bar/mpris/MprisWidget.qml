import QtQuick
import QtQuick.Layouts
import Quickshell

Text {
    id: title
    color: "#ac3231"
    font.family: "BigBlueTermPlusNerdFont"
    text: `${MprisController.activeTrack.title}`
    verticalAlignment: Text.AlignVCenter

    Behavior on color {
        ColorAnimation {
            duration: 200
            easing.type: Easing.InOutQuad
        }
    }
    MouseArea {
        anchors {
            fill: parent
        }
        hoverEnabled: true

        onEntered: title.color = "#cc5251"
        onExited: title.color = "#ac3231"
        onClicked: MprisController.togglePlaying()
        cursorShape: Qt.PointingHandCursor
        onWheel: e => {
            e.accepted = true;
            const step = Math.sign(e.angleDelta.y);
            if (step == 1) {
                MprisController.next();
            } else {
                MprisController.previous();
            }
        }
    }
}
