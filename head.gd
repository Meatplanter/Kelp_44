extends Area2D

var tween: Tween

var crosshair = preload("res://crosshair.tscn")

func look_for_enemy():
	if EnemyManager.enemies.size() > 0 && EnemyManager.targetEnemyLeft == null:
		EnemyManager.targetEnemyLeft = EnemyManager.enemies.front()
	
	if EnemyManager.enemies.size() > 0 && EnemyManager.targetEnemyRight == null:
		EnemyManager.targetEnemyRight = EnemyManager.enemies.front()
	
	if EnemyManager.enemies.size() == 0:
		EnemyManager.targetEnemyLeft = null
		EnemyManager.targetEnemyRight = null
		

func _physics_process(delta):
	look_for_enemy()

func _process(delta):
	EnemyManager.enemy_scope()


func select_next_target_left(direction: Vector2):
	if EnemyManager.targetEnemyLeft == null:
		return
	
	var enemies = EnemyManager.get_enemies()
	var current_pos = EnemyManager.targetEnemyLeft.global_position
	
	var best_enemy: Node2D = null
	var best_score = INF
	
	for enemy in enemies:
		if enemy == EnemyManager.targetEnemyLeft:
			continue
			#
		var to_enemy = (enemy.global_position - current_pos).normalized()
		#
		## Direction check: only consider enemies roughly in that direction
		if direction.dot(to_enemy) > 0.5:  # adjust threshold as needed
			var dist = current_pos.distance_to(enemy.global_position)
			if dist < best_score:
				best_score = dist
				best_enemy = enemy
				##
	if best_enemy:
		EnemyManager.targetEnemyLeft = best_enemy
		

func select_next_target_right(direction: Vector2):
	if EnemyManager.targetEnemyRight == null:
		return
	
	var enemies = EnemyManager.get_enemies()
	var current_pos = EnemyManager.targetEnemyRight.global_position
	
	var best_enemy: Node2D = null
	var best_score = INF
	
	for enemy in enemies:
		if enemy == EnemyManager.targetEnemyRight:
			continue
			#
		var to_enemy = (enemy.global_position - current_pos).normalized()
		#
		## Direction check: only consider enemies roughly in that direction
		if direction.dot(to_enemy) > 0.5:  # adjust threshold as needed
			var dist = current_pos.distance_to(enemy.global_position)
			if dist < best_score:
				best_score = dist
				best_enemy = enemy
				##
	if best_enemy:
		EnemyManager.targetEnemyRight = best_enemy

func _unhandled_input(event):
	if event.is_action_pressed("TargetLGRight"):
		select_next_target_left(Global.VecRight)
	elif event.is_action_pressed("TargetLGLeft"):
		select_next_target_left(Global.VecLeft)
	elif event.is_action_pressed("TargetLGUp"):
		select_next_target_left(Global.VecUp)
	elif event.is_action_pressed("TargetLGDown"):
		select_next_target_left(Global.VecDown)
	elif event.is_action_pressed("TargetRGRight"):
		select_next_target_right(Global.VecRight)
	elif event.is_action_pressed("TargetRGLeft"):
		select_next_target_right(Global.VecLeft)
	elif event.is_action_pressed("TargetRGUp"):
		select_next_target_right(Global.VecUp)
	elif event.is_action_pressed("TargetRGDown"):
		select_next_target_right(Global.VecDown)
