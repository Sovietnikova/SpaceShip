import QtQuick 2.0

Rectangle {
    id: simplebutton
    color: area.containsMouse ? 'yellow': 'gray'
    width: buttonLabel.width + 2*buttonLabel.anchors.leftMargin


    property alias text: buttonLabel.text
    property alias textColor: buttonLabel.color
    property alias textSize: buttonLabel.font.pointSize
    property alias imageSource: simpleImage.source

    signal clicked()

    Image {
        id: simpleImage
        anchors.fill: parent
        source: imageSource
    }


    Text {
        id: buttonLabel
        anchors.left: simplebutton.left
        anchors.top: simplebutton.top
        anchors.leftMargin: 8
        anchors.topMargin: 5
        anchors.centerIn: parent
        color: area.pressed ? "white" : "silver"
        font.pointSize: 50
    }

    MouseArea {
        id: area
        anchors.fill: parent
        onClicked: simplebutton.clicked()
        hoverEnabled: true
        enabled: true
        onPressedChanged: console.log('pressed', pressed)
    }
    Timer {
        id: timerPressed
        interval: 30
        running: area.pressed
        repeat: true
        onTriggered: {
            simplebutton.clicked();
            console.log('click');
        }


    }
}
