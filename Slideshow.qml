import QtQuick

Item {
    id: idControl

    property int fadeSpeed: 1000
    property int interval: 3000
    property var model: ListModel{}

    Component.onCompleted: {
        front.source = model.get(0).source
        if (model.count <= 1) {
            timer.stop()
            return
        }
        back.source = model.get(1).source
    }

    QtObject {
        id: internal
        property int currentIndex: 0
        property int nextIndex: 1
        property bool ab: false

        onCurrentIndexChanged: {
            if (front.opacity === 1) {
                back.source = idControl.model.get(currentIndex).source
            }
        }
    }

    Rectangle {
        id: idContainer
        anchors.fill: parent

        Image {
            id: back
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            Behavior on opacity {
                NumberAnimation { duration: idControl.fadeSpeed }
            }
        }

        Image {
            id: front
            opacity: internal.ab ? 0 : 1
            anchors.fill: parent
            fillMode: Image.PreserveAspectCrop
            onOpacityChanged: {
                if (opacity === 0) {
                    source = idControl.model.get(internal.nextIndex).source
                }
            }
            Behavior on opacity {
                NumberAnimation { duration: idControl.fadeSpeed }
            }
        }
    }

    Timer {
        id: timer
        repeat: true
        running: true
        interval: idControl.interval
        onTriggered: {
            internal.ab = !internal.ab

            const end = idControl.model.count - 1

            if (internal.currentIndex >= end) {
                internal.currentIndex = 0
            } else {
                internal.currentIndex++
            }

            if (internal.nextIndex >= end) {
                internal.nextIndex = 0
            } else {
                internal.nextIndex = internal.currentIndex + 1
            }
        }
    }
}
