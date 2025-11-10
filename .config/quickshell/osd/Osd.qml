pragma ComponentBehavior: Bound
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire
import Quickshell.Widgets
import "../widgets"

Scope {
    id: root

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    property bool shouldShowOsd: false
    property bool showingInput: false
    property real osdOpacityControl: 0.0

    Connections {
        target: Pipewire.defaultAudioSink?.audio

        function onVolumeChanged() {
            root.showingInput = false;
            root.shouldShowOsd = true;
            root.osdOpacityControl = 1.0;
            hideTimer.restart();
        }

        function onMutedChanged() {
            root.showingInput = false;
            root.shouldShowOsd = true;
            root.osdOpacityControl = 1.0;
            hideTimer.restart();
        }
    }

    Connections {
        target: Pipewire.defaultAudioSource?.audio

        function onVolumeChanged() {
            root.showingInput = true;
            root.shouldShowOsd = true;
            root.osdOpacityControl = 1.0;
            hideTimer.restart();
        }

        function onMutedChanged() {
            root.showingInput = true;
            root.shouldShowOsd = true;
            root.osdOpacityControl = 1.0;
            hideTimer.restart();
        }
    }
    Timer {
        id: hideTimer
        interval: 1000
        onTriggered: {
            root.osdOpacityControl = 0;
        }
    }
    LazyLoader {
        active: root.shouldShowOsd
        PanelWindow {
            anchors.bottom: true
            margins.bottom: screen.height / 5
            exclusiveZone: 0
            implicitWidth: 350
            implicitHeight: 70
            color: "transparent"
            mask: Region {}

            Rectangle {
                id: osd
                anchors.fill: parent
                anchors.margins: 6
                color: "#0d0d14"
                opacity: root.osdOpacityControl

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                        easing.type: Easing.InOutQuad
                        onStopped: {
                            if (osd.opacity === 0) {
                                root.shouldShowOsd = false;
                            }
                        }
                    }
                }

                Border {}

                RowLayout {
                    anchors.fill: parent
                    anchors.leftMargin: 15
                    anchors.rightMargin: 15
                    spacing: 12

                    Text {
                        font.family: "BigBlueTermPlusNerdFont"
                        font.pointSize: 24
                        color: "#ac3231"
                        text: {
                            if (root.showingInput) {
                                return Pipewire.defaultAudioSource?.audio.muted ? "󰍭" : "󰍬";
                            } else {
                                const vol = Pipewire.defaultAudioSink?.audio.volume ?? 0;
                                if (Pipewire.defaultAudioSink?.audio.muted)
                                    return "󰝟";
                                else if (vol > 0.6)
                                    return "󰕾";
                                else if (vol > 0.3)
                                    return "󰖀";
                                else
                                    return "󰕿";
                            }
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        implicitHeight: 10
                        color: "#52263e"
                        clip: true

                        Rectangle {
                            anchors.left: parent.left
                            anchors.top: parent.top
                            anchors.bottom: parent.bottom
                            color: "#ac3231"
                            implicitWidth: parent.width * (root.showingInput ? (Pipewire.defaultAudioSource?.audio.volume ?? 0) : (Pipewire.defaultAudioSink?.audio.volume ?? 0))
                            Behavior on implicitWidth {
                                NumberAnimation {
                                    duration: 200
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}
