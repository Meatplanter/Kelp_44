extends CharacterBody2D

var currPos = [0,0]
var targPos = [0,0]
var tween: Tween
var moveTime = Global.moveTime
var sqrt = sqrt(2)
var moveDistance = Global.moveDistance
var maxMoveDistance = Global.maxMoveDistance
var styleTween = Global.styleTween

func shortest_angle(from: float, to: float) -> float:
	var delta = fmod(to - from + PI, TAU) - PI
	return from + delta

func _ready() -> void:
	Global.LeftShoeNode = self

func _input(event):
	if Global.canMove == true && %CharBody.cameraState == 0:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			

		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)

			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x - moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			


	elif Global.canMove == true && %CharBody.cameraState == 1:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y - moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			


	elif Global.canMove == true && %CharBody.cameraState == 2:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)

			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[0] == Global.RightShoeNode.global_position.x + moveDistance && targPos[1] == Global.RightShoeNode.global_position.y: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			


	elif Global.canMove == true && %CharBody.cameraState == 3:
		if event.is_action_pressed("LS_move_right") && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_left") && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_up") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_down") && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_rightdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.leftWeighted == false && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #optimal walking
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true && targPos[1] == Global.RightShoeNode.global_position.y + moveDistance && targPos[0] == Global.RightShoeNode.global_position.x: #returning to walking after taking a step back
				Global.leftWeighted = false
				Global.rightWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftup") && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("LS_move_leftdown") && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %RightShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.leftWeighted == false: #optimal complex movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.leftWeighted == true: #least optimal movement
				Global.leftWeighted = true
				Global.rightWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			

func _process(delta: float) -> void:
	currPos = [int(global_position.x),int(global_position.y)]
	tween = create_tween()
	var from_angle = rotation
	var to_angle = Global.midpoint.angle_to_point(%CharBody.focus)
	var shortest = shortest_angle(from_angle, to_angle)
	tween.tween_property(self,"rotation",shortest+0.5 * PI,moveTime)
	moveTime = Global.moveTime

	if currPos == targPos:
		Global.leftMoving = false
	else:
		Global.leftMoving = true
