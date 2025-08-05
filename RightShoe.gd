extends CharacterBody2D

var currPos = [32,0]
var targPos = [32,0]
var tween: Tween
var moveTime = 0.5
var canMove = true

func _input(event):
	if canMove == true:
		if event.is_action_pressed("RS_move_right"):
			targPos[0] += 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",90,moveTime)
			
		elif event.is_action_pressed("RS_move_left"):
			targPos[0] -= 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",270,moveTime)
			
		elif event.is_action_pressed("RS_move_up"):
			targPos[1] -= 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",0,moveTime)
			
		elif event.is_action_pressed("RS_move_down"):
			targPos[1] += 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",180,moveTime)
			
		elif event.is_action_pressed("RS_move_rightup"):
			targPos[0] += 32
			targPos[1] -= 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",45,moveTime)
			
		elif event.is_action_pressed("RS_move_rightdown"):
			targPos[0] += 32
			targPos[1] += 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",135,moveTime)
			
		elif event.is_action_pressed("RS_move_leftup"):
			targPos[0] -= 32
			targPos[1] -= 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",305,moveTime)
			
		elif event.is_action_pressed("RS_move_leftdown"):
			targPos[0] -= 32
			targPos[1] += 32
			tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),moveTime).set_trans(Tween.TRANS_BACK)
			tween.tween_property(self,"rotation_degrees",225,moveTime)
		
func _process(delta: float) -> void:
	currPos = [int(global_position.x),int(global_position.y)]
	if currPos == targPos:
		canMove = true
	else:
		canMove = false
