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
var maxMoveDistance = Global.maxMoveDistance
var styleTween = Global.styleTween

func _ready() -> void:
	Global.RightShoeNode = self

func _input(event):
	if Global.canMove == true && %CharBody.cameraState == 0 && Global.targettingMode == false:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x + moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			


	elif Global.canMove == true && %CharBody.cameraState == 1 && Global.targettingMode == false:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)

			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y + moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			


	elif Global.canMove == true && %CharBody.cameraState == 2 && Global.targettingMode == false:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[0] == Global.LeftShoeNode.global_position.x - moveDistance && targPos[1] == Global.LeftShoeNode.global_position.y: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			


	elif Global.canMove == true && %CharBody.cameraState == 3 && Global.targettingMode == false:
		if event.is_action_pressed("RS_move_right") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,-1) * moveDistance) != 0:
			targPos[1] -= moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_left") && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(0,1) * moveDistance) != 0:
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y - moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y - moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_up") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,0) * moveDistance) != 0:
			targPos[0] -= moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y - moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y - moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_down") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,0) * moveDistance) != 0:
			targPos[0] += moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y - moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y - moveDistance && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal
				$Shoe/Label.text = str(moveTime)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy
				$Shoe/Label.text = str(moveTime)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)

			
		elif event.is_action_pressed("RS_move_rightup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,-1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_rightdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,-1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] -= moveDistance
			if Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftup") && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(-1,1) * moveDistance) != 0:
			targPos[0] -= moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y - 32 && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y - 32 && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			tween = create_tween()
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(styleTween)
			
		elif event.is_action_pressed("RS_move_leftdown") && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) < maxMoveDistance && %LeftShoe.global_position.distance_to(global_position + Vector2(1,1) * moveDistance) != 0:
			targPos[0] += moveDistance
			targPos[1] += moveDistance
			if Global.rightWeighted == false && targPos[1] == Global.LeftShoeNode.global_position.y - 32 && targPos[0] == Global.LeftShoeNode.global_position.x: #optimal walking
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true && targPos[1] == Global.LeftShoeNode.global_position.y - 32 && targPos[0] == Global.LeftShoeNode.global_position.x: #returning to walking after taking a step back
				Global.rightWeighted = false
				Global.leftWeighted = true
				moveTime = Global.moveSimpleHeavy*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == false: #optimal complex movement
				Global.rightWeighted = true
				Global.leftWeighted = false
				moveTime = Global.moveComplexOptimal*sqrt
				$Shoe/Label.text = str(round(moveTime*100)/100)
			elif Global.rightWeighted == true: #least optimal movement
				Global.rightWeighted = true
				Global.leftWeighted = false
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
	
	if currPos == targPos:
		Global.rightMoving = false
	else:
		Global.rightMoving = true
