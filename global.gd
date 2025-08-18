extends Node

var CharBodyNode = null
var RightShoeNode = null
var LeftShoeNode = null

#game
var gameMode = 0 # 0 = spawn bullets 1 = spawn enemies
var gameSpeed = 1.0 
var normalTime = 1.0
var bulletTime = 0.05

#player
var midpoint = Vector2(0,16)
var playerHealth = 10

#movement
var moveTime = 0.4
var moveDistance = 32

#bullets
var bulletSpeed = 200
var bulletRange = 1000
