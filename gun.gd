extends Area2D

var tween: Tween

var enemyRange = Global.enemyRange

var leftCooldown = 1.0
var rightCooldown = 1.0

var thresholdAim = deg_to_rad(15)

func _draw():
	if get_parent().has_meta("Player") && Global.targetEnemyLeft != null && get_parent().has_meta("Left"):
		var aimFrom = %ShootingPoint.position
		var aimTo = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 500
		var aimDir = (aimTo - aimFrom).normalized()
		var targetDir = (Global.targetEnemyLeft.global_position - aimFrom)
		var angleDiff = aimDir.angle_to(targetDir)
		#if abs(angleDiff) <= thresholdAim: 
		print(rad_to_deg(angleDiff))
		if abs(angleDiff) <= thresholdAim:
			draw_line(aimFrom,aimTo,Color.KHAKI)
		#draw_circle(%ShootingPoint.position,10,Color.RED)

func shortest_angle(from: float, to: float) -> float:
	var delta = fmod(to - from + PI, TAU) - PI
	return from + delta

func _input(event):
	if event.is_action_pressed("ShootLeftGun") && leftCooldown < 0 && get_parent().has_meta("Player") && get_parent().has_meta("Left"):
		shoot()
		leftCooldown = 1.0
	if event.is_action_pressed("ShootRightGun") && rightCooldown < 0 && get_parent().has_meta("Player") && get_parent().has_meta("Right"):
		shoot()
		rightCooldown = 1.0

func _physics_process(delta: float) -> void:
	
	if get_parent().has_meta("Enemy"): #enemy has gun, points it at player
		if global_position.distance_to(Global.midpoint) <= enemyRange: #player in range
			show()
		else:
			hide()
			
			
	elif get_parent().has_meta("Player"): #player has gun, points it at the closest enemy
		if Global.targetEnemyRight != null && Global.targetEnemyLeft != null: #enemy in range
			show()
		else: #enemy outside of range
			hide()
		


func _process(delta: float) -> void:
	if leftCooldown > 0 && get_parent().has_meta("Player") && get_parent().has_meta("Left"):
		$WeaponPivot/Revolver.self_modulate = Color.RED
	elif leftCooldown < 0 && get_parent().has_meta("Player") && get_parent().has_meta("Left"):
		$WeaponPivot/Revolver.self_modulate = Color.GREEN
	if rightCooldown > 0 && get_parent().has_meta("Player") && get_parent().has_meta("Right"):
		$WeaponPivot/Revolver.self_modulate = Color.RED
	elif rightCooldown < 0 && get_parent().has_meta("Player") && get_parent().has_meta("Right"):
		$WeaponPivot/Revolver.self_modulate = Color.GREEN
	
	if is_visible_in_tree() == true:
		if Global.gameSpeed == Global.bulletTime:
			$ShootTimer.set_paused(1)
			$SlomoShootTimer.set_paused(0)
			
			$ShootCooldown.set_paused(1)
			$SlomoShootCooldown.set_paused(0)
		elif Global.gameSpeed == Global.normalTime:
			$SlomoShootTimer.set_paused(1)
			$ShootTimer.set_paused(0)
			
			$SlomoShootCooldown.set_paused(1)
			$ShootCooldown.set_paused(0)
	else:
		$ShootTimer.set_paused(1)
		$SlomoShootTimer.set_paused(1)
		
		$ShootCooldown.set_paused(1)
		$SlomoShootCooldown.set_paused(1)
		
	queue_redraw()


func shoot():
	const BULLET = preload("res://Bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = %ShootingPoint.global_position
	new_bullet.global_rotation = get_parent().global_rotation
	
	if is_visible_in_tree(): #shoot only if gun not hidden
		get_parent().get_parent().add_child(new_bullet)
		
	

func _on_shoot_timer_timeout() -> void:
	if get_parent().has_meta("Enemy"):
		shoot()

func _on_slomo_shoot_timer_timeout() -> void:
	if get_parent().has_meta("Enemy"):
		shoot()


func _on_shoot_cooldown_timeout():
	leftCooldown -= 0.01
	rightCooldown -= 0.01

func _on_slomo_shoot_cooldown_timeout():
	leftCooldown -= 0.01
	rightCooldown -= 0.01
