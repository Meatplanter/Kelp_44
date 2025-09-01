extends Node

#game
var normalTime = 1.0
var bulletTime = 0.05

var gameSpeed = 1.0
var CharBodyNode = null
var RightShoeNode = null
var LeftShoeNode = null
var gameMode = 2 # 0 = spawn bullets 1 = spawn enemies
var bulletsDodged = 0
var enemiesKilled = 0
var cameraState = 0 #0 looking up, 1 looking right, 2 looking down, 3 looking left


#player
var playerHealth = 1000

var midpoint = Vector2(0,16)
var focus = Vector2(0,0)


#movement
var moveTime = 0.4 #useless?
var moveDistance = 32 #base 32
var styleTween = Tween.TRANS_EXPO
var pureMovement = 0.3 #in seconds
var placingWeight = 0.2 #in seconds

var moveSimpleOptimal = pureMovement #e.g. walking forward, first half of movement, raising foot
var moveComplexOptimal = pureMovement + placingWeight #e.g. walking forward, planting foot in front
var moveSimpleHeavy = placingWeight + pureMovement #e.g. retracting step after planting foot
var moveComplexHeavy = placingWeight + pureMovement + placingWeight #e.g. moving same foot outwards twice

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
var targetEnemy = null
var aimingSpeed = 1
var bulletSpeed = 150
var bulletRange = 1000
var bulletSlowdown = 0.998

var bloodTrialVisible = false

#enemy
var enemyHealth = 200
var enemyRange = 300
