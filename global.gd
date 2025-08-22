extends Node

#game
var normalTime = 1.0
var bulletTime = 0.05

var CharBodyNode = null
var RightShoeNode = null
var LeftShoeNode = null
var gameMode = 0 # 0 = spawn bullets 1 = spawn enemies
var bulletsDodged = 0
var enemiesKilled = 0
var gameSpeed = 1.0


#player
var playerHealth = 1000

var midpoint = Vector2(0,16)
var focus = Vector2(0,0)


#movement
var moveTime = 0.4
var moveDistance = 32
var styleTween = Tween.TRANS_EXPO

var leftMoving = false
var rightMoving = false
var canMove = true


#gun & bullets
var aimingSpeed = 1
var bulletSpeed = 200
var bulletRange = 1000


#enemy
var enemyHealth = 100
var enemyRange = 300
