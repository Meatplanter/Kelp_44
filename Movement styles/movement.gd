extends Node

var moveDistance = 32 #base 32
var maxMoveDistance = 65 #at first 75
var styleTween = Tween.TRANS_QUAD #for movement
var pureMovement = 0.3 #in seconds
var placingWeight = 0.2 #in seconds

var moveTime = 0.4

var moveSimpleOptimal: #e.g. walking forward, first half of movement, raising foot
	get: return pureMovement
var moveSimpleHeavy: #e.g. retracting step after planting foot
	get: return placingWeight + pureMovement
var moveComplexOptimal: #e.g. walking forward, planting foot in front
	get: return pureMovement + placingWeight
var moveComplexHeavy: #e.g. moving same foot outwards twice
	get: return placingWeight + pureMovement + placingWeight

var leftMoving = false
var rightMoving = false
var canMove = true
var leftWeighted = true
var rightWeighted = true 
var weightedShoe = "both"

#normalized directions
var rotOffset = 0*PI/2
var DirRight:
	get: return Vector2.RIGHT.rotated(rotOffset)
var DirLeft:
	get: return Vector2.LEFT.rotated(rotOffset)
var DirUp:
	get: return Vector2.UP.rotated(rotOffset)
var DirDown:
	get: return Vector2.DOWN.rotated(rotOffset)
var DirRightUp:
	get: return DirRight + DirUp
var DirRightDown:
	get: return DirRight + DirDown
var DirLeftUp:
	get: return DirLeft + DirUp
var DirLeftDown:
	get: return DirLeft + DirDown

var CurrPosLeft = Vector2(0,0)
var CurrPosRight = Vector2(32,0)
var midpoint = Vector2(16,0)
var focus = Vector2(16,-512)
var orientation = Vector2.UP
var abdomenMidpoint = Vector2(16,0)

var cumulativeAngle = 0
var neck = Vector2(16,0)
var lefShoulder = Vector2(-8,0)
var rightShoulder = Vector2(40,0)
var shoulderFocus = Vector2(16,0)
var shoulderOrientation = Vector2.UP

#func can_move(dir: Vector2) -> bool:
	#var dist = moveDistance
	#if dir * dist = 
#
#func move_right(target: Node2D):
	#var tween: Tween
	#tween = create_tween()
	#tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
	#target.position.x += DirRight * moveDistance
