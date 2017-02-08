import QtQuick 2.0


SequentialAnimation {
        id: fireAnimation

        property var myShipImg

        PropertyAnimation {
            target: myShipImg
            property: 'opacity'
            from: 0
            to: 1
            duration: 200
        }
        PropertyAnimation {
            target: myShipImg
            property: 'opacity'
            from: 1
            to: 0
            duration: 200
        }
    }
