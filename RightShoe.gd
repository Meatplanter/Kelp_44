extends CharacterBody2D

var currPos = [32,0]
var targPos = [32,0]
var tween: Tween

func _input(event):
	if event.is_action_pressed("RS_move_right"):
		targPos[0] += 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",90,0.5)
		
	elif event.is_action_pressed("RS_move_left"):
		targPos[0] -= 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",270,0.5)
		
	elif event.is_action_pressed("RS_move_up"):
		targPos[1] -= 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",0,0.5)
		
	elif event.is_action_pressed("RS_move_down"):
		targPos[1] += 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",180,0.5)
		
	elif event.is_action_pressed("RS_move_rightup"):
		targPos[0] += 32
		targPos[1] -= 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",45,0.5)
		
	elif event.is_action_pressed("RS_move_rightdown"):
		targPos[0] += 32
		targPos[1] += 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",135,0.5)
		
	elif event.is_action_pressed("RS_move_leftup"):
		targPos[0] -= 32
		targPos[1] -= 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",305,0.5)
		
	elif event.is_action_pressed("RS_move_leftdown"):
		targPos[0] -= 32
		targPos[1] += 32
		tween = create_tween()
		tween.set_parallel(true)
		tween.tween_property(self,"position",Vector2(targPos[0],targPos[1]),0.5).set_trans(Tween.TRANS_BACK)
		tween.tween_property(self,"rotation_degrees",225,0.5)
