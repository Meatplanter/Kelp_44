extends Node

#game
var normalTime = 1.0
var bulletTime = 0.05
var timeReverse = -0.3
var targettingMode = false
var timeReverseMode = false
var pausePoint = 0

var gameSpeed = 1.0
var CharBodyNode = null
var RightShoeNode = null
var LeftShoeNode = null
var TorsoCollisionNode = null
var gameMode = 0 # 0 = spawn bullets 1 = spawn enemies
var bulletsDodged = 0
var enemiesKilled = 0
var cameraState = 0 #0 looking up, 1 looking right, 2 looking down, 3 looking left


#player
var character = "Drone_A"
var playerHealth = 10

var midpoint = Vector2(0,16)
var focus = Vector2(0,0)

var xp4bullet = 1
var xp4enemy = 7
var currentExp = 0
var expToLevel = 20

#movement
var moveTime = 0.4 #useless?
var moveDistance = 32 #base 32
var maxMoveDistance = 65 #at first 75
var styleTween = Tween.TRANS_QUAD #for movement
var pureMovement = 0.3 #in seconds
var placingWeight = 0.2 #in seconds


var moveSimpleOptimal: #e.g. walking forward, first half of movement, raising foot
	get:
		return pureMovement
var moveComplexOptimal: #e.g. walking forward, planting foot in front
	get:
		return pureMovement + placingWeight
var moveSimpleHeavy: #e.g. retracting step after planting foot
	get:
		return placingWeight + pureMovement
var moveComplexHeavy: #e.g. moving same foot outwards twice
	get:
		return placingWeight + pureMovement + placingWeight

var leftMoving = false
var rightMoving = false
var canMove = true
var leftWeighted = true
var rightWeighted = true 
var weightedShoe = "both"

#rotations
var bodyRotationCumulative = rad_to_deg(-PI/2) #also initial orientation
var leftGunRotationCumulative = rad_to_deg(-PI) #also initial gun position
var rigtGunRotationCumulative = rad_to_deg(0*PI) #also initial gun position


#gun & bullets
var targetEnemyLeft = null
var targetEnemyRight = null
var leftCanShoot = false
var rightCanShoot = false

var aimingSpeed = 1
var bulletSpeed = 120
var bulletRange = 700
var bulletSlowdown = 0.998

var bloodTrailVisible = true
var bloodTrailScene = false #true is pixels, false is sprite

#enemy
var enemyHealth = 2
var enemyRange = 300


#vector camera normal
var VecRight = Vector2.RIGHT
var VecLeft = Vector2.LEFT
var VecUp = Vector2.UP
var VecDown = Vector2.DOWN
