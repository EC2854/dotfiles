import Quickshell
import Quickshell.Io
import QtQuick
import QtQuick.Effects

PanelWindow {
    id: bg
    property var modelData
    property int randomIndex: Math.floor(Math.random() * (60 - 21 + 1)) + 21

    screen: modelData
    exclusionMode: ExclusionMode.Ignore
    aboveWindows: false
    color: "transparent"

    anchors {
        top: true
        left: true
        bottom: true
        right: true
    }
    Image {
        id: room
        cache: false
        anchors.fill: parent
        fillMode: Image.PreserveAspectCrop
        source: "../assets/bg/bg.png"
        smooth: false
    }
    Image {
        id: skybox
        cache: false
        anchors.fill: parent
        smooth: true
        z: -2

        source: "../assets/bg/skybox/" + bg.randomIndex + ".png"
        fillMode: Image.PreserveAspectCrop
        transformOrigin: Item.Center
        layer.enabled: true
        layer.smooth: false
        layer.textureSize: Qt.size(width, height)

    }
    Image {
        id: mirror
        cache: false
        anchors.fill: parent
        z: -1
        smooth: true

        source: "../assets/bg/mirror/" + bg.randomIndex + ".png"
        fillMode: Image.PreserveAspectCrop
    }
}
