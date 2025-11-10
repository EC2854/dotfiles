import Quickshell
import QtQuick
import "bg" as Bg
import "lock" as Lock
import "bar" as Bar
import "notifs" as Notifs
import "osd" as Osd


ShellRoot {

    Bg.Bg {}
    Bar.Bar {
        id: bar
    }

    Osd.Osd {}
    Notifs.Overlay {
        bar: bar
    }
    Component.onCompleted: () => {
        Lock.Controller.init();
    }
}
