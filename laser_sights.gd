extends Node2D

#func _draw():
	#if get_parent().has_meta("Player") && EnemyManager.targetEnemyLeft != null && get_parent().has_meta("Left"):
		#var aimFrom = %ShootingPoint.position
		#var aimTo = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 50000
		#
		#var direction = (aimTo - aimFrom).normalized()
		#var to_enemy = (to_local(EnemyManager.targetEnemyLeft.global_position) - aimFrom).normalized()
		#
		#var aimAngleDiff = rad_to_deg(abs(direction.angle_to(to_enemy)))
		#
		#if aimAngleDiff < 5:
			#draw_line(aimFrom,aimTo,Color.GREEN)
			#if leftCooldown < 0:
				#shoot()
				#leftCooldown = 1.0
		#else:
			#draw_line(aimFrom,aimTo,Color.KHAKI)
			#
#
#func _process(delta):
	#queue_redraw()
