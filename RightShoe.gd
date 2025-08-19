extends CharacterBody2D

func shortest_angle(from: float, to: float) -> float:
	var delta = fmod(to - from + PI, TAU) - PI
	return from + delta

var currPos = [32,0]
var targPos = [32,0]
var tween: Tween
var moveTime = Global.moveTime
var sqrt = sqrt(2)
var moveDistance = Global.moveDistance
var maxMoveDistance = 75

func _ready() -> void:
	Global.RightShoeNode = self

func _input(event):
	if Global.canMove == true && %CharBody.cameraState == 0:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)


	elif Global.canMove == true && %CharBody.cameraState == 1:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)


	elif Global.canMove == true && %CharBody.cameraState == 2:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)


	elif Global.canMove == true && %CharBody.cameraState == 3:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime*sqrt).set_trans(Tween.TRANS_BACK)

		
func _process(delta: float) -> void:
	currPos = [int(global_position.x),int(global_position.y)]
	tween = create_tween()
	var from_angle = rotation
	var to_angle = Global.midpoint.angle_to_point(%CharBody.focus)
	var shortest = shortest_angle(from_angle, to_angle)
	tween.tween_property(self,"rotation",shortest+0.5 * PI,moveTime)
	
	if currPos == targPos:
		Global.rightMoving = false
	else:
		Global.rightMoving = true
