extends CharacterBody2D

var tween: Tween
var move_speed: float = 50.0 * Global.gameSpeed

func _process(delta: float) -> void:
	look_at(Global.focus)
	rotate(PI/2)

func _physics_process(delta: float) -> void:

	#move the torso towards the weighted leg
	var swayPostion: Vector2
	match Global.weightedShoe:
		"both":
			swayPostion = Global.midpoint
		"left":
			swayPostion = (Global.midpoint + %LeftShoe.global_position) / 2
		"right":
			swayPostion = (Global.midpoint + %RightShoe.global_position) / 2
	global_position = global_position.move_toward(swayPostion, move_speed * delta)
	
	
	if Global.targetEnemy != null:
		var orientation = (Global.focus - Global.midpoint).normalized() #vector perpendicular to the body position
		var targetEnemy = Global.targetEnemy
		
		var enemyDirectionLS = (targetEnemy.global_position - $TorsoPolygon2D/LeftShoulderPivot.global_position).normalized() #angle to enemy from right shoulder
		#var enemyDirectionLE = (targetEnemy.global_position - $TorsoPolygon2D/RightShoulderPivot.global_position).normalized() #angle to enemy from right shoulder
		
		#rotate right shoulder toward enemy
		var enemyDirectionRS = (targetEnemy.global_position - $TorsoPolygon2D/RightShoulderPivot.global_position).normalized() #angle to enemy from right shoulder
		var enemyAngleRS = enemyDirectionRS.angle_to(orientation)
		var clampedAngleRS = -(clamp(enemyAngleRS,-PI/2,PI/4))
		tween = create_tween()
		tween.tween_property($TorsoPolygon2D/RightShoulderPivot, "rotation", clampedAngleRS-PI/2, Global.aimingSpeed).set_ease(Tween.EASE_IN_OUT)

		#rotate right elbow toward enemy
		var enemyDirectionRE = (targetEnemy.global_position - $TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot.global_position).normalized() #angle to enemy from right elbow
		var enemyAngleRE = enemyDirectionRE.angle_to($TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot.global_position) #angle to biceps
		print(enemyAngleRE)
		var clampedAngleRE = -(clamp(enemyAngleRE,-PI/2,PI/4))
		tween = create_tween()
		tween.tween_property($TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot, "rotation", clampedAngleRE-PI/2, Global.aimingSpeed).set_ease(Tween.EASE_IN_OUT)
		
		#tween = create_tween()
		#tween.tween_property($TorsoPolygon2D/RightShoulderPivot, "rotation", clamped_angle-PI/2, Global.aimingSpeed).set_ease(Tween.EASE_IN_OUT)
		
		#rotate right forearm toward enemy
		#var orientation = (Global.focus - Global.midpoint).normalized() #vector perpendicular to the body position
		#var rotationVector = Vector2.UP.rotated(rotation) #currently aiming in objective terms
		#var pointing = -(rotationVector.angle_to(orientation)) #currently aiming in subjective terms
		#
		#var targetEnemy = Global.targetEnemy
		#var enemyDirection = (targetEnemy.global_position - $TorsoPolygon2D/RightShoulderPivot.global_position).normalized() #angle to enemy from shoulder
		#
		#var bodyEnemyAngle = enemyDirection.angle_to(orientation)
		#var clamped_angle = -(clamp(bodyEnemyAngle,-PI/2,PI/4)) #subjective angle to enemy clamped in front of the body
		##var aimAngle = clamped_angle - pointing #how to correct to aim at enemy
		#
		#tween = create_tween()
		#tween.tween_property($TorsoPolygon2D/RightShoulderPivot, "rotation", clamped_angle-PI/2, Global.aimingSpeed).set_ease(Tween.EASE_IN_OUT)

		#print(rad_to_deg(aimAngle))
		#print(rad_to_deg(clamped_angle))
		#print(rad_to_deg(pointing))
		#print(rotationVector)
		#print ("clamped_angle to enemy: ",rad_to_deg(clamped_angle)," Pointing: ",rad_to_deg(pointing)," aimAngle: ",rad_to_deg(aimAngle))
		
		#var RSRot = $TorsoPolygon2D/RightShoulderPivot.rotation
		#Vector2.RIGHT.rotated(rotation)
		#var RSEnem = $TorsoPolygon2D/RightShoulderPivot

		
		#print(rotationVector)

func take_damage():
	Global.playerHealth -= 1
