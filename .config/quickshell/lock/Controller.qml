pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import "." as Lock

Singleton {
    IpcHandler {
        target: "lockscreen"

        function lock(): void {
             lock.locked = true
        }
    }

    WlSessionLock {
        id: lock
        locked: false

        WlSessionLockSurface {
            id: lockSurface
            color: "transparent"
            Lock.Surface {
                anchors.fill: parent
                context: lockContext
            }
        }
    }

    Lock.Context {
        id: lockContext
        onUnlocked: lock.locked = false
    }

    // Empty function to define first reference to singleton
    function init() {
    }
}
