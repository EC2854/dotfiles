import Quickshell.Io
import QtQuick

Rectangle {
    id: border
    anchors {
        fill: parent
    }
    color: "transparent"
    Image {
        cache: false
        z: -1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.topMargin: -6
        source: "../assets/border/top.png"
        fillMode: Image.TileHorizontally
    }

    Image {
        cache: false
        z: -1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottomMargin: -6
        source: "../assets/border/bottom.png"
        fillMode: Image.TileHorizontally
    }

    Image {
        cache: false
        z: -1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: -6
        source: "../assets/border/left.png"
        fillMode: Image.TileHorizontally
    }

    Image {
        cache: false
        z: -1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.rightMargin: -6
        source: "../assets/border/right.png"
        fillMode: Image.TileHorizontally
    }

    Image {
        cache: false
        z: -1
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: -6
        source: "../assets/border/top-left.png"
    }

    Image {
        cache: false
        z: -1
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: -6
        source: "../assets/border/top-right.png"
    }
    Image {
        cache: false
        z: -1
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.margins: -6
        source: "../assets/border/bottom-left.png"
    }
    Image {
        cache: false
        z: -1
        anchors.bottom: parent.bottom
        anchors.right: parent.right
        anchors.margins: -6
        source: "../assets/border/bottom-right.png"
    }
}
