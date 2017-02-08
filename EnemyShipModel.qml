import QtQuick 2.0

ListModel {


    id: enemyShips
    function createEnemyShip() {
        var enemyX = ((Math.random() * root.width + 100) + 1);
        var enemyY = ((Math.random() * root.width + 100) + 1);
        var enemyVelocityX = ((Math.random() * 2) + getRandomSign());
        var enemyVelocityY = ((Math.random() * 2) + getRandomSign());
        var enemyRotation = ((Math.random() * 360) + 1);
        var enemyImg = allShips[Math.floor(Math.random() * (allShips.length-1)) + 1];
        var health = 1;
        enemyShips.append ({'enemyX': enemyX, 'enemyY': enemyY, 'enemyVelocityX': enemyVelocityX, 'enemyVelocityY': enemyVelocityY, 'enemyRotation': enemyRotation, 'enemyImg': enemyImg, 'health': health}) //, 'enemyImg': enemyImg, 'pex': pex, 'pey': pey});
    }

}
