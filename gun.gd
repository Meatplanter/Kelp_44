extends Area2D

var tween: Tween
var aimingSpeed = Global.aimingSpeed
var enemyRange = Global.enemyRange

var targetEnemy
var clamped_angle

func shortest_angle(from: float, to: float) -> float:
	var delta = fmod(to - from + PI, TAU) - PI
	return from + delta

# Utility function to check if an angle is between two others (with wraparound support)
func is_angle_between(angle: float, start: float, end: float) -> bool:
	angle = wrapf(angle, -PI, PI)
	start = wrapf(start, -PI, PI)
	end = wrapf(end, -PI, PI)
	
	if start <= end:
		return start <= angle and angle <= end
	else:
		# Wrapping around the ±PI boundary
		return angle >= start or angle <= end

func closest_clamped_angle(angle: float, min_angle: float, max_angle: float) -> float:
	var angle_dist_to_min = abs(shortest_angle(angle, min_angle))
	var angle_dist_to_max = abs(shortest_angle(angle, max_angle))
	return min_angle if angle_dist_to_min < angle_dist_to_max else max_angle
	

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
			targetEnemy = enemiesInRange.front()
			var target_angle = wrapf(Global.midpoint.angle_to_point(targetEnemy.global_position), -PI, PI)
			var half_fov = PI / 2  # 90 degrees field of view from orientation
			var orientation = wrapf(Global.orientation, -PI, PI)
			
			var min_angle = wrapf(orientation - half_fov, -PI, PI)
			var max_angle = wrapf(orientation + half_fov, -PI, PI)
			
			if is_angle_between(target_angle, min_angle, max_angle):
				clamped_angle = target_angle
				print("in sight")
			else:
				clamped_angle = closest_clamped_angle(target_angle, min_angle, max_angle)
				print("can't see")
				
			var shortest = shortest_angle(rotation, clamped_angle)
			tween = create_tween()
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
