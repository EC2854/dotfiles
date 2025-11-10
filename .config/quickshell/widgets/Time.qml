import QtQuick
import QtQuick.Layouts

RowLayout {
    id: root
    required property int size
    property bool showDate: false

    spacing: 12

    Text {
        id: datetxt
        text: Qt.formatDateTime(new Date(), "ddd MMM dd ")
        font.family: "BigBlueTermPlusNerdFont"
        font.pointSize: root.size
        color: "#52263e"
        textFormat: Text.PlainText

        visible: root.showDate

        Behavior on visible {
            NumberAnimation {
                duration: 150
                easing.type: Easing.InOutQuad
            }
        }
    }

    Text {
        id: timetxt
        text: Qt.formatDateTime(new Date(), "hh") + "<span style='color:#52263e'>:</span>" + Qt.formatDateTime(new Date(), "mm")
        font.family: "BigBlueTermPlusNerdFont"
        font.pointSize: root.size
        color: "#ac3231"
        textFormat: Text.RichText
    }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            timetxt.text = Qt.formatDateTime(new Date(), "hh") + "<span style='color:#52263e'>:</span>" + Qt.formatDateTime(new Date(), "mm");
            if (datetxt.visible)
                datetxt.text = Qt.formatDateTime(new Date(), "ddd MMM dd");
        }
    }
}
