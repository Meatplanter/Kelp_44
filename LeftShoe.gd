extends CharacterBody2D

var currPos = [0,0]
var targPos = [0,0]
var tween: Tween
var moveTime = 0.5
var canMove = true
var moveDistance = 32
var maxMoveDistance = 75

func _input(event):
	if canMove == true && %CharBody.cameraState == 0:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			


	elif canMove == true && %CharBody.cameraState == 1:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)


	elif canMove == true && %CharBody.cameraState == 2:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)


	elif canMove == true && %CharBody.cameraState == 3:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
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
	if currPos == targPos:
		canMove = true
	else:
		canMove = false
