extends Area2D

var tween: Tween

var crosshair = preload("res://crosshair.tscn")

func _physics_process(delta):
	if EnemyManager.enemies.size() > 0:
		EnemyManager.targetEnemyLeft = EnemyManager.enemies.front()
		EnemyManager.targetEnemyRight = EnemyManager.enemies.front()
	else:
		EnemyManager.targetEnemyLeft = null
		EnemyManager.targetEnemyRight = null

func _process(delta):
	if EnemyManager.targetEnemyLeft != null:
		var crosshairLeft = crosshair.instantiate()
		EnemyManager.targetEnemyLeft.add_child(crosshairLeft)
		
	if EnemyManager.targetEnemyRight != null:
		var crosshairRight = crosshair.instantiate()
		crosshairRight.global_rotation = PI/4
		EnemyManager.targetEnemyRight.add_child(crosshairRight)
		



#func _physics_process(delta):
	#
	#enemiesInRange.clear()
	#
	#for body in get_overlapping_bodies():
		#if body.has_meta("Enemy") && body.get_meta("Enemy") == true:
			#enemiesInRange.append(body)
			#
	#if enemiesInRange.size() > 0:
		#targetEnemyLeft = enemiesInRange.front()
		#targetEnemyRight = enemiesInRange.front()
		##tween = create_tween()
		##tween.tween_property(self,"rotation",)
		##look_at(targetEnemy.global_position)
	#else:
		#targetEnemyLeft = null
		#targetEnemyRight = null
	#
	#EnemyManager.targetEnemyLeft = targetEnemyLeft
	#EnemyManager.targetEnemyRight = targetEnemyRight
