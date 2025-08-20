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
var playerHealth = 10

var midpoint = Vector2(0,16)
var focus = Vector2(0,0)
var orientation = 0.0 #angle midpointo to focus


#movement
var moveTime = 0.4
var moveDistance = 32

var leftMoving = false
var rightMoving = false
var canMove = true


#gun & bullets
var aimingSpeed = 1
var bulletSpeed = 200
var bulletRange = 1000


#enemy
var enemyHealth = 10
var enemyRange = 300
