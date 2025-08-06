extends CharacterBody2D

var currPos = [32,0]
var targPos = [32,0]
var tween: Tween
var moveTime = 0.5
var canMove = true
var moveDistance = 32
var maxMoveDistance = 75

func _input(event):
	if canMove == true && %CharBody.cameraState == 0:
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
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)


	elif canMove == true && %CharBody.cameraState == 1:
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
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)


	elif canMove == true && %CharBody.cameraState == 2:
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
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)


	elif canMove == true && %CharBody.cameraState == 3:
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
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)

		
func _process(delta: float) -> void:
	currPos = [int(global_position.x),int(global_position.y)]
	if %CharBody.midpoint.angle_to_point(%CharBody.focus) * 180/PI < -91:
		tween = create_tween()
		tween.tween_property(self,"rotation",%CharBody.midpoint.angle_to_point(%CharBody.focus) + 0.5 * PI,moveTime)
	else:
		tween = create_tween()
		tween.tween_property(self,"rotation",abs(%CharBody.midpoint.angle_to_point(%CharBody.focus) + 0.5 * PI),moveTime)
	print(%CharBody.midpoint.angle_to_point(%CharBody.focus) * 180/PI)
	if currPos == targPos:
		canMove = true
	else:
		canMove = false
