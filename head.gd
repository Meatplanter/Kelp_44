extends Area2D

var tween: Tween

var crosshair = preload("res://crosshair.tscn")

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
const DETECT_RADIUS = 2000
const FOV = 220

func look_for_enemy():
	if EnemyManager.enemies.size() > 0 && EnemyManager.targetEnemyLeft == null:
		EnemyManager.targetEnemyLeft = EnemyManager.enemies.front()
	
	if EnemyManager.enemies.size() > 0 && EnemyManager.targetEnemyRight == null:
		EnemyManager.targetEnemyRight = EnemyManager.enemies.front()
	
	if EnemyManager.enemies.size() == 0:
		EnemyManager.targetEnemyLeft = null
		EnemyManager.targetEnemyRight = null
		

func _physics_process(delta):
	#look_for_enemy()
	self.global_position = Movement.neck

func _process(delta):
	EnemyManager.enemy_scope()
	#EnemyManager.get_visible_enemies()
	
	#trying to implement field of vision
	var pos = Global.midpoint
	direction = (Global.focus - Global.midpoint).normalized()
	angle = 90 - rad_to_deg(direction.angle())
	
	for enemy in EnemyManager.get_enemies():
		enemy_direction = (enemy.global_position - Global.midpoint).normalized()
		if pos.distance_to(enemy.global_position) < DETECT_RADIUS:
			var angle_to_node = rad_to_deg(direction.angle_to(enemy_direction))
			if abs(angle_to_node) < FOV/2: #if enemy is visible
				enemy.modulate.a = min(1,enemy.modulate.a + delta * Global.gameSpeed * 2)
			else:
				enemy.modulate.a = max(0.0,enemy.modulate.a - delta * Global.gameSpeed)


func select_next_target_left(direction: Vector2):
	if EnemyManager.targetEnemyLeft == null:
		return
	
	var enemies = EnemyManager.get_visible_enemies()
	var current_pos = EnemyManager.targetEnemyLeft.global_position
	
	var best_enemy: Node2D = null
	var best_score = INF
	
	for enemy in enemies:
		if enemy == EnemyManager.targetEnemyLeft:
			continue
			#
		var to_enemy = (enemy.global_position - current_pos).normalized()
		#
		# Direction check: only consider enemies roughly in that direction
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
	
	var enemies = EnemyManager.get_visible_enemies()
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
