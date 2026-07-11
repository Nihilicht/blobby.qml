import QtQuick
import Blobby 1.0

Window {
    width: 800
    height: 600
    visible: true
    title: "Blobby Metaball Test"
    color: "#1a1a1a"

    BlobGroup {
        id: mainGroup
        color: "#00d2ff" // Vibrant Cyan
        smoothing: 40
    }

    BlobRect {
        id: blob1
        group: mainGroup
        x: 100
        y: 100
        width: 200
        height: 200
        topLeftRadius: 0
        topRightRadius: 0
        bottomLeftRadius: 0
        bottomRightRadius: 0
        physicsEnabled: false
        
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            drag.target: blob1
        }
    }

    BlobRect {
        id: blob2
        group: mainGroup
        x: 400
        y: 200
        width: 150
        height: 150
        topLeftRadius: 40
        topRightRadius: 40
        bottomLeftRadius: 40
        bottomRightRadius: 40
        physicsEnabled: true
        
        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            drag.target: blob2
        }
    }

    Text {
        anchors.bottom: parent.bottom
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20
        text: "Left blob: Rigid (physicsEnabled: false) | Right blob: Jiggly (physicsEnabled: true)"
        color: "white"
        font.pixelSize: 18
    }
}
