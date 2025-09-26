extends Node

var moveDistance = 32 #base 32
var maxMoveDistance = 65 #at first 75
var styleTween = Tween.TRANS_QUAD #for movement
var pureMovement = 0.3 #in seconds
var placingWeight = 0.2 #in seconds

var moveTime = 0.4

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

#normalized directions
var DirRight = Vector2.RIGHT
var DirLeft = Vector2.LEFT
var DirUp = Vector2.UP
var DirDown = Vector2.DOWN
var DirRightUp = Vector2(1,-1)
var DirRightDown = Vector2(1,1)
var DirLeftUp = Vector2(-1,-1)
var DirLeftDown = Vector2(-1,1)

var CurrPosLeft = Vector2(0,0)
var CurrPosRight = Vector2(32,0)
var midpoint = Vector2(16,0)
var focus = Vector2(16,-512)
var orientation = Vector2.UP

var cumulativeAngle = 0

#func can_move(dir: Vector2) -> bool:
	#var dist = moveDistance
	#if dir * dist = 
#
#func move_right(target: Node2D):
	#var tween: Tween
	#tween = create_tween()
	#tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
	#target.position.x += DirRight * moveDistance
