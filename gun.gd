extends Area2D

var tween: Tween
var aimingSpeed = Global.aimingSpeed
var enemyRange = Global.enemyRange

func shortest_angle(from: float, to: float) -> float:
	var delta = fmod(to - from + PI, TAU) - PI
	return from + delta

func _physics_process(delta: float) -> void:
	if get_parent().has_meta("Enemy"): #enemy has gun, points it at player
		if global_position.distance_to(Global.midpoint) <= enemyRange: #player in range
			show()
			tween = create_tween()
			var from_angle = rotation
			var to_angle = global_position.angle_to_point(Global.midpoint)
			var shortest = shortest_angle(from_angle, to_angle)
			tween.tween_property(self, "rotation", shortest, aimingSpeed).set_ease(Tween.EASE_IN_OUT)
		else:
			hide()
	elif get_parent().has_meta("Player"): #player has gun, points it at the closest enemy
		global_position = Global.midpoint
		var enemiesInRange = get_overlapping_bodies()
		if enemiesInRange.size() > 0: #enemy in range
			show()
			var targetEnemy = enemiesInRange.front()
			var target_angle = Global.midpoint.angle_to_point(targetEnemy.global_position)
			tween = create_tween()
			var from_angle = rotation
			var to_angle = Global.midpoint.angle_to_point(targetEnemy.global_position)
			var shortest = shortest_angle(from_angle, to_angle)
			tween.tween_property(self, "rotation", shortest, aimingSpeed).set_ease(Tween.EASE_IN_OUT)
		else: #enemy outside of range
			hide()
		
		#print(Global.midpoint.angle_to_point(global_position))


func _process(delta: float) -> void:
	if is_visible_in_tree() == true:
		if Global.gameSpeed == Global.bulletTime:
			$ShootTimer.set_paused(1)
			$SlomoShootTimer.set_paused(0)
		elif Global.gameSpeed == Global.normalTime:
			$SlomoShootTimer.set_paused(1)
			$ShootTimer.set_paused(0)
	else:
		$ShootTimer.set_paused(1)
		$SlomoShootTimer.set_paused(1)

func shoot():
	const BULLET = preload("res://Bullet.tscn")
	var new_bullet = BULLET.instantiate()
	
	if get_parent().has_meta("Enemy"): #enemy has gun, shoots player
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = rotation 
	elif get_parent().has_meta("Player"): #player has gun, shoots closest enemy
		new_bullet.global_position = %ShootingPoint.global_position
		var enemiesInRange = get_overlapping_bodies()
		if enemiesInRange.size() > 0:
			var targetEnemy = enemiesInRange.front()
			new_bullet.global_rotation = rotation 
	
	if is_visible_in_tree(): #don't shoot if parent hidden
		get_parent().get_parent().add_child(new_bullet) #bullet doesn't disappear when enemy does
	


func _on_shoot_timer_timeout() -> void:
	shoot()

func _on_slomo_shoot_timer_timeout() -> void:
	shoot()
