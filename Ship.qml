import QtQuick 2.5

Item {
    id: root

    property int size: 200
    property alias source: myShipImg.source
    signal exploded

    Image {
        id: myShipImg
        source: source
        x: -width/2
        y: -width/2
        opacity: myShipOpacity
        width: size
        height: size

//        Rectangle{
//            id: fire
//            width: size/2
//            height: 150
//            visible: true
//            color: 'transparent'
            //rotation: fireRotation
           // x: fireImgX
            //y: fireImgY


            Image {
                id: fire
                width: size/2
                height: 150
                visible: true
                opacity: 0.1
                source: 'Images/fire.png'
                anchors.centerIn: parent
                anchors.horizontalCenterOffset: -.4 * parent.height
                anchors.verticalCenterOffset: -.01 * parent.height
            }


        BlinkAnimation {
            id: blA
            myShipImg: myShipImg
        }

        FireAnimation {
            id: fA
            myShipImg: fire
        }

        Explosion {
            id: exA
            myShipImg: myShipImg

            onStopped: root.exploded();

            //onComplete: root.exploded
        }

    }
    function blink() {
        blA.start();
    }
    function explode() {
        exA.start();
    }
    function fire() {
        fA.start();
    }




}
