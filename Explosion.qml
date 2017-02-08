import QtQuick 2.5


SequentialAnimation {
    id: myShipExploshion
     property var myShipImg
     PropertyAnimation {
         target: myShipImg
         property: 'source'
         to: 'Images/explosion3.png'
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
        from: 1
        to: 0.4
        duration: 300
    }
//        ScriptAction {
//            script: {
//                endGame();
//                gameOver.visible = true;
//            }
//        }
}
