extends Area2D


func _physics_process(delta: float) -> void:
	if get_parent().has_meta("Enemy"): #enemy has gun, points it at player
		look_at(Global.midpoint)
	elif get_parent().has_meta("Player"): #player has gun, points it at the closest enemy
		global_position = Global.midpoint
		var enemiesInRange = get_overlapping_bodies()
		if enemiesInRange.size() > 0:
			var targetEnemy = enemiesInRange.front()
			look_at(targetEnemy.global_position)


func _process(delta: float) -> void:
	if Global.gameMode == 0:
		hide()
	elif Global.gameMode == 1:
		show()
	if Global.gameSpeed == 0.1:
		$ShootTimer.set_paused(1)
		$SlomoShootTimer.set_paused(0)
	else:
		$SlomoShootTimer.set_paused(1)
		$ShootTimer.set_paused(0)

func shoot():
	const BULLET = preload("res://Bullet.tscn")
	var new_bullet = BULLET.instantiate()
	
	if get_parent().has_meta("Enemy"): #enemy has gun, shoots player
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_position.angle_to_point(Global.midpoint)
	elif get_parent().has_meta("Player"): #player has gun, shoots closest enemy
		new_bullet.global_position = %ShootingPoint.global_position
		var enemiesInRange = get_overlapping_bodies()
		if enemiesInRange.size() > 0:
			var targetEnemy = enemiesInRange.front()
			new_bullet.global_rotation = %ShootingPoint.global_position.angle_to_point(targetEnemy.global_position)
	
	add_child(new_bullet)
	


func _on_shoot_timer_timeout() -> void:
	shoot()

func _on_slomo_shoot_timer_timeout() -> void:
	shoot()
