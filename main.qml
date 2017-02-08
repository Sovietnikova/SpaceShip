import QtQuick 2.0
import QtQuick.Controls 1.4
import QtMultimedia 5.4

ApplicationWindow  {
    id: root
    width: 1600
    height: 1600
    visible: true

    property int shipVelocityX: 0
    property int shipVelocityY: 2
    property int shipX: 300
    property int shipY: 700
    property int shipSize: 200
    property int bulletsSize: shipSize/10

    property int fireImgX: shipX - 50
    property int fireImgY: shipY + 20
    property real fireOpacity: 0.4
    property int fireVX: shipVelocityX
    property int fireVY: shipVelocityY
    property int fireRotation: shipRotation

    property string myShip: 'Images/myShip.png'
    property int endY: -80
    property int beginY: root.height + 1
    property int killEnemyShips: 0
    readonly property int speed: 5
    property int forChoosingShip: 0
    property int isKilledMyShip: 3

    property real myShipOpacity: 1

    property int startX: (root.width - allShipsImages.width)/2

    property int shipRotation: 270 //Math.atan2(velocityY, velocityX) * 180 / Math.PI
    property var allShips: ['Images/1.png', 'Images/2.png', 'Images/3.png', 'Images/4.png', 'Images/5.png', 'Images/6.png', 'Images/7.png', 'Images/8.png', 'Images/9.png', 'Images/10.png', 'Images/11.png', 'Images/12.png', 'Images/13.png', 'Images/14.png', 'Images/myShip.png', 'Images/enemy.png']

    Image {
        source: "Images/space.jpg"
        anchors.fill: parent
    }

    function startGame() {
        ship.source = myShip;
        countDeadEnemies.visible = true;
        ship.visible = true;
        isKilledMyShip = 3;
        buttonDown.visible = true;
        buttonLeft.visible = true;
        buttonRight.visible = true;
        buttonUp.visible = true;
        buttonShoot.visible = true;
        buttonEscape.visible = true;
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
        shotSound.play();
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
        countDeadEnemies.visible = false;
        ship.visible = false;
        buttonDown.visible = false;
        buttonLeft.visible = false;
        buttonRight.visible = false;
        buttonUp.visible = false;
        buttonShoot.visible = false;
        buttonEscape.visible = false;
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
            source: "Images/space.jpg"
            anchors.fill: startWindow
        }

        Text {
            id: gameName
            color: "#359190"
            text: 'Spaceship Buttle'
            font.bold: true
            styleColor: "#b5b1b1"
            verticalAlignment: Text.AlignVCenter
            horizontalAlignment: Text.AlignHCenter
            style: Text.Sunken
            font.pointSize: 44
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: startWindow.top
            anchors.topMargin: 50
        }

        SimpleButton {
            id: button_start
            text: 'Start'
            //textColor: 'silver'
            color: "transparent"
            radius: 10
            height: root.height/10
            anchors.centerIn: parent
            onClicked: {
                startWindow.visible = false;
                startGame();

            }
        }
        SimpleButton {
            id: buttonChooseShip
            text: 'Choose Ship'
            //textColor: 'silver'
            color: "transparent"
            radius: 10
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: button_start.bottom
            anchors.topMargin: 30
            height: root.height/10
            onClicked: {
                startWindow.visible = false;
                chooseShipWindow.visible = true;
                console.log(chooseShipWindow.width, chooseShipWindow.height);
            }
        }
    }


    ParallelAnimation {
        id: a0

        //            property var nulll
        //            property int fromX: fromX
        //            property var toX: toX

        PropertyAnimation {
            id: a1
            target: allShipsImages
            property: 'x'
            from: startX
            to: startX - root.width
            duration: 1000
        }
        PropertyAnimation {
            id: a2
            target: backRightImage
            property: 'x'
            from: startX + root.width
            to: startX
            duration: 1000
        }
        onStarted: {
            backRightImage.visible = true;
        }

        onStopped: {
            allShipsImages.source = backRightImage.source;
            allShipsImages.x = backRightImage.x;
            backRightImage.visible = false;
            forChoosingShip += 1;
        }
    }

    ParallelAnimation {
        id: a20

        //            property var nulll
        //            property int fromX: fromX
        //            property var toX: toX

        PropertyAnimation {
            id: a21
            target: allShipsImages
            property: 'x'
            from: startX
            to: startX + root.width
            duration: 1000
        }
        PropertyAnimation {
            id: a22
            target: backLeftImage
            property: 'x'
            from: startX - root.width
            to: startX
            duration: 1000
        }
        onStarted: {
            backLeftImage.visible = true;
        }

        onStopped: {
            allShipsImages.source = backLeftImage.source;
            allShipsImages.x = backLeftImage.x;
            backLeftImage.visible = false;
            forChoosingShip -= 1;
            if (forChoosingShip <= 0) {
                forChoosingShip = allShips.length;
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
        Image {
            id: backRightImage
            width: chooseShipWindow.width/1.5
            height: chooseShipWindow.height/1.5
            rotation: 270
            x: (root.width - width)/2
            y: (root.height - height)/2
            source: allShips[(forChoosingShip + 1)%allShips.length]
            visible: false
        }
        Image {
            id: backLeftImage
            width: chooseShipWindow.width/1.5
            height: chooseShipWindow.height/1.5
            rotation: 270
            x: (root.width - width)/2
            y: (root.height - height)/2
            source: allShips[(allShips.length + forChoosingShip - 1) % allShips.length]
            visible: false
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
            imageSource: 'Images/left.png'
            onClicked: {
                a20.start();
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
            imageSource: 'Images/right.png'
            onClicked: {
                a0.start();

            }
        }

        SimpleButton {
            id: back
            color: 'transparent'
            height: 110
            width: 200
            imageSource: 'Images/back.png'
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
            //textColor: 'silver'
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
            //textColor: 'silver'
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
            //textColor: 'silver'
            width: 100
            height: 100
            color: 'transparent'
            anchors.left: pause.left
            anchors.leftMargin: 20
            anchors.top: textExit.bottom
            anchors.bottomMargin: 30
            onClicked: {
                pause.visible = false;
                startWindow.visible = true;
                endGame();
            }
        }
        SimpleButton {
            id: no
            width: 100
            height: 100
            //textColor: 'silver'
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


    Ship {
        id: ship
        source: myShip
        x: shipX
        y: shipY
        opacity: myShipOpacity
        rotation: shipRotation
        visible: false

        onExploded: {
            gameOver.visible = true;
            endGame();
        }

    }

    SimpleButton{
        id: buttonLeft
        imageSource: 'Images/left.png'
        width: 70
        height: 70
        color: 'transparent'
        anchors.left: parent.left
        anchors.leftMargin: 20
        anchors.top: parent.top
        anchors.topMargin: 300
        visible: false
        onClicked: {
            shipRotation -= 2;
        }
    }

    PressedButton{
        id: buttonRight
        imageSource: 'Images/right.png'
        width: 70
        height: 70
        color: 'transparent'
        anchors.left: parent.left
        anchors.leftMargin: 100
        anchors.top: parent.top
        anchors.topMargin: 300
        visible: false
        onClicked: {
            shipRotation += 2;
        }
    }

    PressedButton{
        id: buttonUp
        imageSource: 'Images/up.png'
        width: 70
        height: 70
        color: 'transparent'
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.top: parent.top
        anchors.topMargin: 240
        visible: false
        onClicked: {
            fireAnimation.start();
            pushShip.play();
            var alfa = shipRotation * (Math.PI/180);
            var px = speed * Math.cos(alfa);
            var py = speed * Math.sin(alfa);
            shipVelocityX += px;
            shipVelocityY -= py;
        }
    }

    PressedButton{
        id: buttonDown
        imageSource: 'Images/down.png'
        width: 70
        height: 70
        color: 'transparent'
        anchors.left: parent.left
        anchors.leftMargin: 60
        anchors.top: parent.top
        anchors.topMargin: 360
        visible: false
        onClicked: {
            var alfa = shipRotation * (Math.PI/180);
            var px = 5 * Math.cos(alfa);
            var py = 5 * Math.sin(alfa);
            shipVelocityX -= px;
            shipVelocityY += py;
        }
    }
    PressedButton {
        id: buttonShoot
        imageSource: 'Images/shoot.png'
        width: 150
        height: 150
        color: 'transparent'
        anchors.right: parent.right
        anchors.rightMargin: 60
        anchors.top: parent.top
        anchors.topMargin: 300
        visible: false
        onClicked: {
            root.shoot(shipRotation, shipX, shipY, shipVelocityX, shipVelocityY, bullets.index, false);
        }
    }
    SimpleButton{
        id: buttonEscape
        imageSource: 'Images/back.png'
        width: 150
        height: 50
        color: 'transparent'
        anchors.left: parent.left
        anchors.leftMargin: 30
        anchors.top: parent.top
        anchors.topMargin: 30
        visible: false
        onClicked: {
            pause.visible = true;
            timer.stop();
            timerEnemies.stop();
        }
    }

    Item {

        Audio {
            id: pushShip
            source: "Sounds/aircraft052.wav"
        }

        Audio {
            id: explosion
            source: "Sounds/aircraft013.wav"
        }
        Audio {
            id: shotSound
            source: "Sounds/newShoot.wav"
        }


        focus: true
        Keys.onRightPressed: {
            shipRotation += 2;
        }
        Keys.onLeftPressed: {
            shipRotation -= 2;
        }

        Keys.onUpPressed: {
            pushShip.play();
            ship.fire();
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
        }

        Keys.onSpacePressed: {
            root.shoot(shipRotation, shipX, shipY, shipVelocityX, shipVelocityY, bullets.index, false);
        }


        Keys.onEscapePressed: {
            pause.visible = true;
            timer.stop();
            timerEnemies.stop();
        }

        Keys.onTabPressed: {
            isKilledMyShip = 1;
        }
    }

    Repeater {
        model: bullets
        Rectangle {
            id: oneBullet
            width: bulletsSize
            height: bulletsSize
            radius: 30
            border.color: "#000000"
            color: "#dd5ead"
            x: bulletX
            y: bulletY
        }
    }

    ListModel {
        id: bullets
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
                    explosion.play();
                    bullets.remove(index, 1);
                    index -= 1;
                    isKilledMyShip -= 1;
                    //console.log(ship.toString());
                    ship.blink();
                    if (isKilledMyShip < 1) {
                        ship.explode();
                        //endGame();
                        //gameOver.visible = true;
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
                    //var enemyHealth = enemyShips.get(enemyIndex).health;

                    enemyShips.setProperty(enemyIndex, 'enemyX', ex + vx);
                    enemyShips.setProperty(enemyIndex, 'enemyY', ey - vy);

                    if (ifEnemy === false && killShip(ex, ey, x, y)){ //kill enemyShip
                        //console.log('remove', ifEnemy);
                        explosion.play();
                        enemyShips.setProperty(enemyIndex, 'health', 0);

                        bullets.remove(index, 1);
                        index -= 1;

                        //enemyIndex -= 1;
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
        }
    }

    Repeater {
        model: enemyShips

        Ship {
            id: enemyShip

            x: enemyX
            y: enemyY
            source: enemyImg
            rotation: enemyRotation
            property int health: model.health
            onHealthChanged: {
                if(health == 0) {
                    enemyShip.explode();
                }
            }
            onExploded: {
                enemyShips.remove(index, 1);
            }
        }
    }

    EnemyShipModel {
        id: enemyShips
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
                root.shoot(enemyShips.get(index).enemyRotation, enemyShips.get(index).enemyX, enemyShips.get(index).enemyY, enemyShips.get(index).enemyVelocityX, enemyShips.get(index).enemyVelocityY, index, true);
            }
        }
    }
}


