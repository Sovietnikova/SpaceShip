import QtQuick 2.0
import QtQuick.Controls 1.4

ApplicationWindow  {
    id: root
    width: 1600
    height: 1600
    visible: true

    property int shipVelocityX: 0
    property int shipVelocityY: 2
    property int shipX: 300
    property int shipY: 700
    property string myShip: 'myShip.png'
    property string enemyImg: ''
    //Component.onCompleted: console.log(Math.floor(Math.random() * allShips.length) + 1);

    property int endY: -80
    property int beginY: root.height + 1

    property int killEnemyShips: 0

    readonly property int speed: 5

    property int forChoosingShip: 0

    property int isKilledMyShip: 3

   // property int myShipOpacity: 1


    property int shipRotation: 270 //Math.atan2(velocityY, velocityX) * 180 / Math.PI

    property var allShips: ['1.png', '2.png', '3.png', '4.png', '5.png', '6.png', '7.png', '8.png', '9.png', '10.png', '11.png', '12.png', '13.png', '14.png', 'myShip.png', 'enemy.png']
    //property

    //    SoundEffect {
    //            id: playSound
    //            source: "soundeffect.wav"
    //        }

    Image {
        source: "space.jpg"
        anchors.fill: parent
    }

    function startGame() {
        countDeadEnemies.visible = true;
        boat.visible = true;
        timer.start();
        timerEnemies.start();
    }

    function shoot(shipsRotation, shipsX, shipsY, shipsVelocityX, shipsVelocityY, index, isEnemy) { //make shoot from ships
        var alfa = shipsRotation  * (Math.PI/180);
        var radius = 50;
        var deltaX = radius * Math.cos(alfa);
        var deltaY = radius * Math.sin(alfa);
        var bulletX = shipsX + deltaX - 5;
        var bulletY = shipsY + deltaY - 10;
        var bulletVelocityX = shipsVelocityX + deltaX * 0.2;
        var bulletVelocityY = shipsVelocityY - deltaY * 0.2;
        bullets.append ({'bulletX': bulletX, 'bulletY': bulletY, 'bulletVelocityX': bulletVelocityX, 'bulletVelocityY': bulletVelocityY, 'enemy': isEnemy});
    }


    function getRandomSign() {
        var randomSign = Math.random();
        if (randomSign < 0.5) {
            return -1;
        }

        else {
            return 1;
        }
    }

    function killShip(shipsX, shipsY, bulletsX, bulletsY) {
        if (bulletsX <= shipsX + 90 && bulletsX >= shipsX - 90 && bulletsY <= shipsY +90 && bulletsY >= shipsY - 90) {
            return true;
        }
        return false;
    }


    function endGame() {
        timer.stop();
        timerEnemies.stop();
        killEnemyShips = 0;
        isKilledMyShip = 3;
        countDeadEnemies.visible = false;
        boat.visible = false;
        bullets.clear();
        enemyShips.clear();

    }

    Text{
        id: countDeadEnemies
        anchors.right: parent.right
        anchors.rightMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 20
        z: 1
        color: "#d5bbbb"
        opacity: 0.6
        text:  'lives: ' + isKilledMyShip +  '  enemies: '+ killEnemyShips
        font.family: "Segoe UI Black"
        font.bold: true
        font.pointSize: 16
        visible: false
    }


    Rectangle {
        id: startWindow
        width: root.width
        height: root.height
        color: "#4762ad"
        visible: true
        z: 1

        Image {
            id: startImage
            source: "space.jpg"
            anchors.fill: startWindow
        }

        SimpleButton {
            id: button_start
            text: 'Start'
            textColor: 'silver'
            color: "transparent"
            radius: 10
            height: root.height/10
            anchors.left: startWindow.left
            anchors.leftMargin: 500
            anchors.top: startWindow.top
            anchors.topMargin: root.height/2 - 100
            onClicked: {
                startWindow.visible = false;
                startGame();

            }
        }
        SimpleButton {
            id: buttonChooseShip
            text: 'Choose Ship'
            textColor: 'silver'
            color: "transparent"
            radius: 10
            height: root.height/10
            anchors.left: startWindow.left
            anchors.leftMargin: 260
            anchors.top: button_start.top
            anchors.topMargin: 170
            onClicked: {
                startWindow.visible = false;
                chooseShipWindow.visible = true;
                console.log(chooseShipWindow.width, chooseShipWindow.height);
            }
        }
    }

    Rectangle {
        id: chooseShipWindow
        width: root.width
        height: root.height
        visible: false
        color: 'transparent'


        Image {
            id: allShipsImages
            width: chooseShipWindow.width/1.5
            height: chooseShipWindow.height/1.5
            rotation: 270
            x: (root.width - width)/2
            y: (root.height - height)/2
            source: allShips[forChoosingShip]
        }

        SimpleButton {
            id: left
            //height: 110
            height: 300
            width: 300
            color: 'transparent'
            anchors.left: chooseShipWindow.left
            anchors.leftMargin: 20
            anchors.top: chooseShipWindow.top
            anchors.topMargin: chooseShipWindow.height/2 - 100
            //text: 'left'
            imageSource: 'left.png'
            onClicked: {
                if (forChoosingShip > 0) {
                    forChoosingShip -= 1;
                }
            }
        }

        SimpleButton {
            id: right
            height: 300
            width: 300
            color: 'transparent'
            anchors.right: chooseShipWindow.right
            anchors.leftMargin: 20
            anchors.top: chooseShipWindow.top
            anchors.topMargin: chooseShipWindow.height/2 - 100
            imageSource: 'right.png'
            onClicked: {
                if (forChoosingShip < allShips.length - 1) {
                    forChoosingShip += 1;
                }

            }

        }

        SimpleButton {
            id: back
            color: 'transparent'
            height: 110
            width: 200
            imageSource: 'back.png'
            anchors.left: chooseShipWindow.left
            anchors.leftMargin: 20
            anchors.top: chooseShipWindow.top
            anchors.topMargin: 50
            //text: 'back'
            onClicked: {
                chooseShipWindow.visible = false;
                startWindow.visible = true;
                console.log(chooseShipWindow.visible, startWindow.visible);
            }
        }

        SimpleButton {
            id: selectShip
            //height: 110
            height: 250
            //width: 250
            color: 'transparent'
            anchors.left: chooseShipWindow.left
            anchors.leftMargin: chooseShipWindow.width/2 - 150
            anchors.bottom: chooseShipWindow.bottom
            anchors.bottomMargin: 100
            text: 'Select'
            textSize: 40
            textColor: 'silver'
            //imageSource: 'space.jpg'
            onClicked: {
                myShip = allShips[forChoosingShip];
                console.log('beeep');
                chooseShipWindow.visible = false;
                startGame();
            }

        }
    }

    Rectangle {
        id: gameOver
        visible: false
        x: (root.width - width)/2
        y: (root.height - height)/2
        width: root.width/3
        height: root/height/3
        color: 'green'
        z: 2

        Text {
            id: textGameOver
            anchors.top: gameOver.top
            anchors.topMargin: 20
            anchors.left: gameOver.left
            anchors.leftMargin: 50
            color: "silver"
            text: 'Game over'
            font.family: "MS PGothic"
            font.bold: true
            font.pointSize: 40
            horizontalAlignment: Text.AlignHCenter
        }

        SimpleButton {
            height: 50
            width: 50
            text: 'OK'
            textSize: 30
            textColor: 'silver'
            color: 'transparent'
            anchors.top: textGameOver.bottom
            anchors.topMargin: 20
            anchors.left: gameOver.left
            anchors.leftMargin: 180
            onClicked: {
                startWindow.visible = true;
                gameOver.visible = false;

            }
        }
    }

    Rectangle {
        id: pause
        visible: false
        x: (root.width - width)/2
        y: (root.height - height)/2
        width: root.width/3
        height: root/height/3
        color: 'transparent'

        Text {
            id: textExit
            text: "Exit?"
            color: 'silver'
            font.pointSize: 40
            anchors.top: pause.top
            anchors.topMargin: 30
            anchors.centerIn: pause

        }

        SimpleButton {
            id: yes
            text: 'Y'
            textColor: 'silver'
            width: 100
            height: 100
            color: 'transparent'
            anchors.left: pause.left
            anchors.leftMargin: 20
            anchors.top: textExit.bottom
            anchors.bottomMargin: 30
            onClicked: {
                //root.visible = false;
                pause.visible = false;
                startWindow.visible = true;
                //boat.visible = false;
                endGame();
            }
        }
        SimpleButton {
            id: no
            width: 100
            height: 100
            textColor: 'silver'
            text: 'N'
            color: 'transparent'
            anchors.right: pause.right
            anchors.leftMargin: 20
            anchors.top: textExit.bottom
            anchors.bottomMargin: 30
            onClicked: {
                pause.visible = false;
                timer.start();
                timerEnemies.start();
            }
        }
    }


    Item {
        id: boat
        x: shipX
        y: shipY
        rotation: shipRotation

        visible: false

        Image {
            id: img
            source: myShip
            x: -width/2
            y: -width/2
            //opacity: myShipOpacity
            width: 200
            height: 200
        }

    }

    Item {
        focus: true
        Keys.onRightPressed: {
            shipRotation += 2;
        }
        Keys.onLeftPressed: {
            shipRotation -= 2;
        }

        Keys.onUpPressed: {
            var alfa = shipRotation * (Math.PI/180);
            var px = speed * Math.cos(alfa);
            var py = speed * Math.sin(alfa);

            shipVelocityX += px;
            shipVelocityY -= py;
            //console.log('vx', shipVelocityX, 'vy', shipVelocityY, 'px', px, 'py', py)
        }

        Keys.onDownPressed: {
            var alfa = shipRotation * (Math.PI/180);
            var px = 5 * Math.cos(alfa);
            var py = 5 * Math.sin(alfa);

            shipVelocityX -= px;
            shipVelocityY += py;
            //console.log('vx', shipVelocityX, 'vy', shipVelocityY, 'px', px, 'py', py)

        }

        Keys.onSpacePressed: {
            root.shoot(shipRotation, shipX, shipY, shipVelocityX, shipVelocityY, bullets.index, false);

        }


        Keys.onEscapePressed: {
            pause.visible = true;
            timer.stop();
            timerEnemies.stop();
        }


    }
    Repeater {
        model: bullets
        Rectangle {
            id: oneBullet
            width: 20
            height: 20
            radius: 30
            border.color: "#000000"
            color: "#dd5ead"
            x: bulletX
            y: bulletY
        }
    }

    ListModel {
        id: bullets
        //Component.onCompleted: root.shoot(shipRotation, shipX, shipY, shipVelocityX, shipVelocityY, 0, false);

    }

    Timer {
        id: timer
        interval: 100
        repeat: true
        running: true
        onTriggered: {
            shipX += shipVelocityX; //move our ship
            shipY -= shipVelocityY;

            var index = 0;
            for (index; index < bullets.count; index ++) { //move bullets
                //console.log('bullets', bullets.count)
                var x = bullets.get(index).bulletX;
                var y = bullets.get(index).bulletY;
                var ifEnemy = bullets.get(index).enemy;
                var velocityX = bullets.get(index).bulletVelocityX;
                var velocityY = bullets.get(index).bulletVelocityY;
                bullets.setProperty(index, "bulletX", x + velocityX);
                bullets.setProperty(index, "bulletY", y - velocityY);

                if (ifEnemy === true && killShip(shipX, shipY, x, y)){ //kill our ship
                    //console.log('remove', ifEnemy);
                    bullets.remove(index, 1);
                    index -= 1;
                    isKilledMyShip -= 1;
                    //myShipOpacity -= 0.1;
                    if (isKilledMyShip < 1) {
                        endGame();
                        gameOver.visible = true;
                    }

                }

                if (x > root.width || x < 0 || y > root.height || y < 0) { //check if bullets go outside our field
                    bullets.remove(index, 1);
                    index -= 1;
                }

                var enemyIndex = 0;
                for (enemyIndex; enemyIndex < enemyShips.count; enemyIndex ++) { //move enemy ships
                    var ex = enemyShips.get(enemyIndex).enemyX;
                    var ey = enemyShips.get(enemyIndex).enemyY;
                    var vx = enemyShips.get(enemyIndex).enemyVelocityX;
                    var vy = enemyShips.get(enemyIndex).enemyVelocityY;
                    var pex = enemyShips.get(enemyIndex).pex;
                    var pey = enemyShips.get(enemyIndex).pey;

                    enemyShips.setProperty(enemyIndex, 'enemyX', ex + vx);
                    enemyShips.setProperty(enemyIndex, 'enemyY', ey - vy);

                    if (ifEnemy === false && killShip(ex, ey, x, y)){ //kill enemyShip
                        //console.log('remove', ifEnemy);
                        bullets.remove(index, 1);
                        index -= 1;
                        enemyShips.remove(enemyIndex, 1);
                        enemyIndex -= 1;
                        killEnemyShips += 1;
                    }
                    if (ex > root.width + 100 || ex < -100 || ey > root.height || ey < -100) { //check if nemy ships outside our field
                        enemyShips.remove(enemyIndex, 1);
                        enemyIndex -= 1;
                    }
                }
            }

            if (shipY <= endY) { // if our ship outside the field, it appear in the other side
                shipY = root.height;
            }
            if (shipY >= beginY) {
                shipY = -30;
            }

            if (shipX >= 1700) {
                shipX = -10;
            }
            if (shipX <= -90) {
                shipX = 1650;
            }

            //console.log('shipX', shipX, 'shipY', shipY, 'shipRotation', shipRotation);

        }
    }

    function getRandomEnemyShip() {
        var randomDigit = (Math.random() * allShips.length) + 1;
        console.log(randomDigit);
        var randomEnemy = allShips[randomDigit];
        console.log(randomEnemy);
        return randomEnemy;
    }

    Repeater {
        model: enemyShips
        Item {
            id: oneEnemy
            //color: 'green'
            x: enemyX
            y: enemyY



            Image {
                id: imgEnemy
                source: enemyImg
                width: 200
                height: 200
                rotation: enemyRotation
                x: -width/2
                y: -width/2
            }


        }
    }

    ListModel {
        id: enemyShips
        function createEnemyShip() {
            var enemyX = ((Math.random() * root.width + 100) + 1);
            var enemyY = ((Math.random() * root.width + 100) + 1);
            var enemyVelocityX = ((Math.random() * 2) + getRandomSign());
            var enemyVelocityY = ((Math.random() * 2) + getRandomSign());
            var enemyRotation = ((Math.random() * 360) + 1);
            enemyImg = allShips[Math.floor(Math.random() * allShips.length) + 1];
            enemyShips.append ({'enemyX': enemyX, 'enemyY': enemyY, 'enemyVelocityX': enemyVelocityX, 'enemyVelocityY': enemyVelocityY, 'enemyRotation': enemyRotation}) //, 'enemyImg': enemyImg, 'pex': pex, 'pey': pey});
        }
    }

    Timer {
        id: timerEnemies
        interval: 3000
        repeat: true
        running: false
        onTriggered: {
            enemyShips.createEnemyShip();
            var index = 0;
            for (index; index < enemyShips.count; index ++) { //change rotation for enemy ships
                var newRotation = enemyShips.get(index).enemyRotation + 10 + getRandomSign();
                enemyShips.setProperty(index, 'enemyRotation', newRotation);
                //console.log('enemyImg>>>>', enemyImg);
                root.shoot(enemyShips.get(index).enemyRotation, enemyShips.get(index).enemyX, enemyShips.get(index).enemyY, enemyShips.get(index).enemyVelocityX, enemyShips.get(index).enemyVelocityY, index, true);
            }
        }
    }
}


