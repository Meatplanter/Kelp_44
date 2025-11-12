extends Area2D

var cameraRotationTween: Tween
var scanningTween: Tween
var turningTween: Tween

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
@export var detectRadius = 2000
var FOV = 220

var Vision: Array = []

#func scanning():
	#


#var headScanning = true #head is searching for a new enemy
#var scanningRight = true #false means scanning left
#
#
#
#func reset_to_scanning():
	#if scanningTween: scanningTween.play()
	#headScanning = true
#
#func scanning():
	#if %HeadAS2.rotation_degrees > Movement.cumulativeAngle + 45: scanningRight = false
	#elif %HeadAS2.rotation_degrees < Movement.cumulativeAngle - 45: scanningRight = true
	#
	#if scanningRight == true:
		#scanningTween = create_tween()
		#scanningTween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle + 60, 1 / TimeManager.gameSpeed)
	#elif scanningRight == false:
		#scanningTween = create_tween()
		#scanningTween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle - 60, 1 / TimeManager.gameSpeed)
#
#func notice_enemy():
	#for ray in Vision:
		#if ray.is_colliding():
			#var collider = ray.get_collider()
			#if collider and collider.is_in_group("Enemy"): #gain attention while looked at
				#collider.attention += TimeManager.gameSpeed
				#collider.lastNoticed = 25.0
	#
	##reset who is being looked at, so that it can be established below
	#if EnemyManager.EnemiesNoticed.is_empty():
		#return null
	#else:
		#for enemy in EnemyManager.EnemiesNoticed:
			#enemy.beingLookedAt = false
	#
	#if %VisionCenter.is_colliding():
		#var collider = %VisionCenter.get_collider()
		#if collider and collider.is_in_group("Enemy"):
			#collider.attention += TimeManager.gameSpeed * 2 #triple the speed of gaining attention when looked at directly
			#collider.beingLookedAt = true
			#if collider.attention >= 100.0: collider.lastMemorized += TimeManager.gameSpeed * 2 #prolong the grace period, so you don't start forgetting the enemy you're accidentaly looking at
		#if collider and collider.is_in_group("Dummy"): collider.threat = -100
#
#
#func turn_to_enemy(target):
	#if scanningTween: scanningTween.pause()
	#headScanning = false
	#
	#var headOrientation = (to_global(%VisionCenter.target_position) - %HeadAS2.global_position).normalized()
	#var targetOrientation = (target.global_position - %HeadAS2.global_position).normalized()
	#var angleTo = rad_to_deg(headOrientation.angle_to(targetOrientation))
	#var targetAngle = clampf(%HeadAS2.rotation_degrees + angleTo,Movement.cumulativeAngle - 90,Movement.cumulativeAngle + 90)
	#turningTween = create_tween()
	#turningTween.tween_property(%HeadAS2,"rotation_degrees",targetAngle, 0.3 / TimeManager.gameSpeed)


func vision_baseline():
	%VisionRightPeriph.rotate(PI/8)
	%VisionLeftPeriph.rotate(-PI/8)
	%VisionRightPeriph2.rotate(PI/4)
	%VisionLeftPeriph2.rotate(-PI/4)
	%VisionRightPeriph3.rotate(PI*0.375)
	%VisionLeftPeriph3.rotate(-PI*0.375)
	%VisionCenter.target_position.y = - detectRadius
	%VisionRightPeriph.target_position.y = - detectRadius
	%VisionLeftPeriph.target_position.y = - detectRadius
	%VisionRightPeriph2.target_position.y = - detectRadius
	%VisionLeftPeriph2.target_position.y = - detectRadius
	%VisionRightPeriph3.target_position.y = - detectRadius
	%VisionLeftPeriph3.target_position.y = - detectRadius
	var VisionTemp = [%VisionRightPeriph,%VisionRightPeriph2,%VisionRightPeriph3,%VisionLeftPeriph,%VisionLeftPeriph2,%VisionLeftPeriph3,%VisionCenter]
	Vision.append_array(VisionTemp)

func _ready():
	SignalBus.connect("cameraRotated", Callable(self, "_on_camera_2d_new_camera_rotated"))
	vision_baseline()

func _process(delta):
	#if headScanning == true: scanning()
	#notice_enemy()
	var sorted_targets = EnemyManager.sort_enemies_by_importance(EnemyManager.EnemiesNoticed) 
	var target = sorted_targets[0] if sorted_targets.size() > 0 else null
	
	print(target)
	
	#trying to implement field of vision
	var pos = self.global_position
	direction = Movement.orientation
	angle = 90 - rad_to_deg(direction.angle())
	
	for enemy in EnemyManager.get_enemies():
		enemy_direction = (enemy.global_position - self.global_position).normalized()
		if pos.distance_to(enemy.global_position) < detectRadius:
			var angle_to_node = rad_to_deg(direction.angle_to(enemy_direction))
			if abs(angle_to_node) < FOV/2: #if enemy is visible
				enemy.modulate.a = min(1,enemy.modulate.a + delta * TimeManager.gameSpeed * 2)
			else:
				enemy.modulate.a = max(0.0,enemy.modulate.a - delta * TimeManager.gameSpeed)
	




func _on_camera_2d_new_camera_rotated(turning):
	if turning == "right":
		cameraRotationTween = create_tween()
		cameraRotationTween.tween_property(%HeadAS2,"rotation",%HeadAS2.rotation+PI/2,0.5).set_trans(Movement.styleTween)
	if turning == "left":
		cameraRotationTween = create_tween()
		cameraRotationTween.tween_property(%HeadAS2,"rotation",%HeadAS2.rotation-PI/2,0.5).set_trans(Movement.styleTween)
