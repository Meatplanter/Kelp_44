extends Area2D

var tween: Tween

var enemyRange = Global.enemyRange

var leftCooldown = 1.0
var rightCooldown = 1.0

var targetEnemyLeft = EnemyManager.targetEnemyLeft
var targetEnemyRight = EnemyManager.targetEnemyRight

var direction = (Global.focus - Global.midpoint).normalized()

func _draw():
	if get_parent().has_meta("Player") && EnemyManager.targetEnemyLeft != null && get_parent().has_meta("Left"):
		var aimFrom = %ShootingPoint.position
		var aimTo = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 50000
		
		var direction = (aimTo - aimFrom).normalized()
		var to_enemy = (to_local(EnemyManager.targetEnemyLeft.global_position) - aimFrom).normalized()
		
		var aimAngleDiff = rad_to_deg(abs(direction.angle_to(to_enemy)))
		
		if aimAngleDiff < 5:
			draw_line(aimFrom,aimTo,Color.GREEN)
			if leftCooldown < 0:
				shoot()
				leftCooldown = 1.0
		else:
			draw_line(aimFrom,aimTo,Color.KHAKI)

	elif get_parent().has_meta("Player") && EnemyManager.targetEnemyRight != null && get_parent().has_meta("Right"):
		var aimFrom = %ShootingPoint.position
		var aimTo = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 50000
		
		var direction = (aimTo - aimFrom).normalized()
		var to_enemy = (to_local(EnemyManager.targetEnemyRight.global_position) - aimFrom).normalized()
		
		var aimAngleDiff = rad_to_deg(abs(direction.angle_to(to_enemy)))
		
		if aimAngleDiff < 5:
			draw_line(aimFrom,aimTo,Color.GREEN)
			if rightCooldown < 0:
				shoot()
				rightCooldown = 1.0
		else:
			draw_line(aimFrom,aimTo,Color.KHAKI)

func shortest_angle(from: float, to: float) -> float:
	var delta = fmod(to - from + PI, TAU) - PI
	return from + delta

func select_next_target_left(direction: Vector2):
	if not targetEnemyLeft:
		return

	var enemies = EnemyManager.get_enemies()
	var current_pos = targetEnemyLeft.global_position

	var best_enemy: Node2D = null
	var best_score = INF

	for enemy in enemies:
		if enemy == targetEnemyLeft:
			continue

		var to_enemy = (EnemyManager.enemy.global_position - current_pos).normalized()

		# Direction check: only consider enemies roughly in that direction
		if direction.dot(to_enemy) > 0.5:  # adjust threshold as needed
			var dist = current_pos.distance_to(EnemyManager.enemy.global_position)
			if dist < best_score:
				best_score = dist
				best_enemy = enemy
				
	if best_enemy:
		targetEnemyLeft = best_enemy
		#highlight_target(targetEnemyLeft)

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
		if EnemyManager.targetEnemyRight != null && EnemyManager.targetEnemyLeft != null: #enemy in range
			show()
		else: #enemy outside of range
			hide()
		


func _process(delta: float) -> void:
	if leftCooldown > 0 && get_parent().has_meta("Player") && get_parent().has_meta("Left"):
		$WeaponPivot/Revolver.self_modulate = Color.RED
		Global.leftCanShoot = false
	elif leftCooldown < 0 && get_parent().has_meta("Player") && get_parent().has_meta("Left"):
		$WeaponPivot/Revolver.self_modulate = Color.GREEN
		Global.leftCanShoot = true
	if rightCooldown > 0 && get_parent().has_meta("Player") && get_parent().has_meta("Right"):
		$WeaponPivot/Revolver.self_modulate = Color.RED
		Global.rightCanShoot = false
	elif rightCooldown < 0 && get_parent().has_meta("Player") && get_parent().has_meta("Right"):
		$WeaponPivot/Revolver.self_modulate = Color.GREEN
		Global.rightCanShoot = true
	
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
		get_tree().get_current_scene().add_child(new_bullet)
		#get_parent().get_parent().get_parent().add_child(new_bullet)
		
	

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
