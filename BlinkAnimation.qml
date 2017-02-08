import QtQuick 2.0


SequentialAnimation {
    id: root

    property var myShipImg
    PropertyAnimation {
        target: myShipImg
        property: 'opacity'
        from: 1
        to: 0.4
        duration: 300
    }
    PropertyAnimation {
        target: myShipImg
        property: 'opacity'
        from: 0.4
        to: 1
        duration: 300
    }
    PropertyAnimation {
        target: myShipImg
        property: 'opacity'
        from: 1
        to: 0.4
        duration: 300
    }
    PropertyAnimation {
        target: myShipImg
        property: 'opacity'
        from: 0.4
        to: 1
        duration: 300
    }
    PropertyAnimation {
        target: myShipImg
        property: 'opacity'
        from: 1
        to: 0.4
        duration: 300
    }
    PropertyAnimation {
        target: myShipImg
        property: 'opacity'
        from: 0.4
        to: 1
        duration: 300
    }
}
