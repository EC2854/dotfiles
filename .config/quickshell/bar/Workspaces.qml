pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import QtQuick.Layouts
import Quickshell.Hyprland

MouseArea {
    id: root

    required property var bar
    property int wsBaseIndex: 1
    property int wsCount: 7
    readonly property HyprlandMonitor monitor: Hyprland.monitorFor(bar.screen)
    property int currentIndex: 0
    property int existsCount: 0

    signal workspaceAdded(workspace: HyprlandWorkspace)

    implicitWidth: row.implicitWidth
    implicitHeight: row.implicitHeight

    acceptedButtons: Qt.NoButton

    onWheel: e => {
        e.accepted = true;
        const step = -Math.sign(e.angleDelta.y);
        const targetWs = currentIndex + step;

        if (targetWs >= wsBaseIndex && targetWs < wsBaseIndex + wsCount) {
            Hyprland.dispatch(`workspace ${targetWs}`);
        }
    }

    RowLayout {
        id: row

        anchors.fill: parent
        spacing: 8

        Repeater {
            model: root.wsCount

            MouseArea {
                id: wsItem

                required property int index
                property int wsIndex: root.wsBaseIndex + index
                property HyprlandWorkspace workspace: null
                property bool exists: workspace != null
                property bool active: (root.monitor?.activeWorkspace ?? false) && root.monitor.activeWorkspace == workspace

                implicitWidth: 24
                implicitHeight: 24

                acceptedButtons: Qt.LeftButton

                cursorShape: Qt.PointingHandCursor

                onPressed: Hyprland.dispatch(`workspace ${wsIndex}`)

                onExistsChanged: {
                    root.existsCount += exists ? 1 : -1;
                }

                onActiveChanged: {
                    if (active)
                        root.currentIndex = wsIndex;
                }

                Connections {
                    target: root

                    function onWorkspaceAdded(workspace: HyprlandWorkspace) {
                        if (workspace.id == wsItem.wsIndex) {
                            wsItem.workspace = workspace;
                        }
                    }
                }

                Rectangle {
                    id: fill
                    anchors.fill: parent
                    anchors.margins: 2
                    radius: width / 2
                    color: wsItem.exists ? (wsItem.active ? "#ac3231" : "#52263e") : "#0d0d14"

                    Behavior on color {
                        ColorAnimation {
                            duration: 300
                            easing.type: Easing.InOutQuad
                        }
                    }
                }

                Image {
                    anchors.fill: parent
                    smooth: false
                    source: "../assets/workspace-button.png"
                }
            }
        }
    }

    Connections {
        target: Hyprland.workspaces

        function onObjectInsertedPost(workspace) {
            root.workspaceAdded(workspace);
        }
    }

    Component.onCompleted: {
        Hyprland.workspaces.values.forEach(workspace => {
            root.workspaceAdded(workspace);
        });
    }
}
