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
	if EnemyManager.targetEnemyLeft != null:
		var crosshairLeft = crosshair.instantiate()
		EnemyManager.targetEnemyLeft.add_child(crosshairLeft)
		
	if EnemyManager.targetEnemyRight != null:
		var crosshairRight = crosshair.instantiate()
		crosshairRight.global_rotation = PI/4
		EnemyManager.targetEnemyRight.add_child(crosshairRight)
	
	EnemyManager.enemy_scope()


#func select_next_target_left(direction: Vector2):
	#if EnemyManager.targetEnemyLeft == null:
		#return
##
	#var enemies = EnemyManager.get_enemies()
	#var current_pos = EnemyManager.targetEnemyLeft.global_position
##
	#var best_enemy: Node2D = null
	#var best_score = INF
##
	#for enemy in enemies:
		#if enemy == EnemyManager.targetEnemyLeft:
			#continue
			#
		#var to_enemy = (EnemyManager.enemy.global_position - current_pos).normalized()
		#
		## Direction check: only consider enemies roughly in that direction
		#if direction.dot(to_enemy) > 0.5:  # adjust threshold as needed
			#var dist = current_pos.distance_to(EnemyManager.enemy.global_position)
			#if dist < best_score:
				#best_score = dist
				#best_enemy = enemy
				##
	#if best_enemy:
		#targetEnemyLeft = best_enemy
		##highlight_target(targetEnemyLeft)
