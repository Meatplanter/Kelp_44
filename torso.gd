extends CharacterBody2D

var tween: Tween
var move_speed: float = 50.0 * Global.gameSpeed
var shoulderRotationOffset = 2 #so that the shoulder rotates quicker and adjust to the changing position better, not messing your aim so much, etc.

func _process(delta: float) -> void:
	look_at(Global.focus)
	rotate(PI/2)
	
	
	#if Global.gameSpeed == 1:
		#shoulderRotationOffset = 3
	#else:
		#shoulderRotationOffset = 1

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
	
	global_position = global_position.move_toward(swayPostion, move_speed * delta * Global.gameSpeed)
	
	
	if Global.targetEnemyLeft != null && Global.targetEnemyRight != null:
		var orientation = (Global.focus - Global.midpoint).normalized() #vector perpendicular to the body position
		var targetEnemyLeft = Global.targetEnemyLeft
		var targetEnemyRight = Global.targetEnemyRight
		
		#var enemyDirectionLE = (targetEnemy.global_position - $TorsoPolygon2D/RightShoulderPivot.global_position).normalized() #angle to enemy from right shoulder
		
		#rotate right shoulder toward enemy
		var enemyDirectionRS = (targetEnemyRight.global_position - $TorsoPolygon2D/RightShoulderPivot.global_position).normalized() #angle to enemy from right shoulder
		var enemyAngleRS = enemyDirectionRS.angle_to(orientation)
		var clampedAngleRS = -(clamp(enemyAngleRS,-PI/2,PI/4))
		tween = create_tween()
		tween.tween_property($TorsoPolygon2D/RightShoulderPivot, "rotation", clampedAngleRS-PI/2, Global.aimingSpeed/Global.gameSpeed/shoulderRotationOffset)#.set_ease(Tween.EASE_IN_OUT)

		#rotate right elbow toward enemy
		var bicepMidpointR = ($TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot.global_position + $TorsoPolygon2D/RightShoulderPivot.global_position)*0.5
		var bicepDirectionalR = $TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot.global_position - $TorsoPolygon2D/RightShoulderPivot.global_position
		var bicepNormalR = Vector2(-bicepDirectionalR.y,bicepDirectionalR.x).normalized()
		var bicepFocusR = bicepMidpointR + bicepNormalR * -512
		var bicepOrientationR = (bicepFocusR - bicepMidpointR).normalized()
		
		var enemyDirectionRE = (targetEnemyRight.global_position - $TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot.global_position).normalized() #angle to enemy from right elbow
		var enemyAngleRE = enemyDirectionRE.angle_to(bicepOrientationR) #angle to biceps
		var clampedAngleRE = -(clamp(enemyAngleRE,-PI/2,0))
		tween = create_tween()
		tween.tween_property($TorsoPolygon2D/RightShoulderPivot/RightBiceps/RightElbowPivot, "rotation", clampedAngleRE-PI/2, Global.aimingSpeed/Global.gameSpeed)#.set_ease(Tween.EASE_IN_OUT)
		
		#rotate left shoulder toward enemy
		var enemyDirectionLS = (targetEnemyLeft.global_position - $TorsoPolygon2D/LeftShoulderPivot.global_position).normalized() #angle to enemy from left shoulder
		var enemyAngleLS = enemyDirectionLS.angle_to(orientation)
		var clampedAngleLS = -(clamp(enemyAngleLS,-PI/4,PI/2))
		tween = create_tween()
		tween.tween_property($TorsoPolygon2D/LeftShoulderPivot, "rotation", clampedAngleLS-PI/2, Global.aimingSpeed/Global.gameSpeed/shoulderRotationOffset)#.set_ease(Tween.EASE_IN_OUT)
		
		#rotate left elbow toward enemy
		var bicepMidpointL = ($TorsoPolygon2D/LeftShoulderPivot/LeftBiceps/LeftElbowPivot.global_position + $TorsoPolygon2D/LeftShoulderPivot.global_position)*0.5
		var bicepDirectionalL = $TorsoPolygon2D/LeftShoulderPivot/LeftBiceps/LeftElbowPivot.global_position - $TorsoPolygon2D/LeftShoulderPivot.global_position
		var bicepNormalL = Vector2(-bicepDirectionalL.y,bicepDirectionalL.x).normalized()
		var bicepFocusL = bicepMidpointL + bicepNormalL * -512
		var bicepOrientationL = (bicepFocusL - bicepMidpointL).normalized()
		
		var enemyDirectionLE = (targetEnemyLeft.global_position - $TorsoPolygon2D/LeftShoulderPivot/LeftBiceps/LeftElbowPivot.global_position).normalized() #angle to enemy from right elbow
		var enemyAngleLE = enemyDirectionLE.angle_to(bicepOrientationL) #angle to biceps
		var clampedAngleLE = -(clamp(enemyAngleLE,-PI,-PI/2))
		tween = create_tween()
		tween.tween_property($TorsoPolygon2D/LeftShoulderPivot/LeftBiceps/LeftElbowPivot, "rotation", clampedAngleLE-PI/2, Global.aimingSpeed/Global.gameSpeed)#.set_ease(Tween.EASE_IN_OUT)
		
		#print(Global.aimingSpeed/Global.gameSpeed/10)
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
