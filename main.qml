import QtQuick
import QtQuick.Window

Window {
    width: 800
    height: 500
    visible: true
    title: qsTr("Slideshow")

    ListModel {
        id: images
        ListElement { source: "qrc:/images/01.jpg" }
        ListElement { source: "qrc:/images/02.jpeg" }
        ListElement { source: "qrc:/images/03.jpg" }
        ListElement { source: "qrc:/images/04.jpg" }
        ListElement { source: "qrc:/images/05.jpg" }
    }

    Slideshow {
        anchors.fill: parent
        anchors.margins: 30
        model: images
    }
}
