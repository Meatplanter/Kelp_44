extends Area2D

var cameraRotationTween: Tween
var scanningTween: Tween
var turningTween: Tween

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
@export var detectRadius = 200
var FOV = 220
var retargetCD = 2.0

var Vision: Array = []

func turn_to_enemy(target):
	if turningTween: turningTween.stop()
	var headOrientation = (to_global(%VisionCenter.target_position) - %HeadAS2.global_position).normalized()
	var targetOrientation = (target.global_position - %HeadAS2.global_position).normalized()
	var angleTo = rad_to_deg(headOrientation.angle_to(targetOrientation))
	var targetAngle = clampf(%HeadAS2.rotation_degrees + angleTo,Movement.cumulativeAngle - 90,Movement.cumulativeAngle + 90)
	var rotSpeed = clampf((abs(angleTo)/90),0.1,0.4)
	turningTween = create_tween()
	turningTween.tween_property(%HeadAS2,"rotation_degrees",targetAngle, rotSpeed / TimeManager.gameSpeed)


func notice_enemy():
	for ray in Vision:
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and collider.is_in_group("Enemy") and collider.attention < 75: #gain attention while looked at
				collider.attention += TimeManager.gameSpeed * 2
	
	if %VisionCenter.is_colliding():
		var collider = %VisionCenter.get_collider()
		if collider and collider.is_in_group("Enemy"):
			collider.attention += TimeManager.gameSpeed * 5 #bonus attention gain when looked at directly
			#collider.beingLookedAt = true
			if int(collider.attention) == 101: collider.attention += 50.0 #prolong the grace period, so you don't start forgetting the enemy you're accidentaly looking at
		if collider and collider.is_in_group("Dummy"): collider.threat = -100


func vision_baseline():
	%VisionCenter.target_position.y = - detectRadius
	%VisionRightPeriph.target_position.y = - detectRadius
	%VisionLeftPeriph.target_position.y = - detectRadius
	%VisionRightPeriph2.target_position.y = - detectRadius
	%VisionLeftPeriph2.target_position.y = - detectRadius
	%VisionRightPeriph3.target_position.y = - detectRadius
	%VisionLeftPeriph3.target_position.y = - detectRadius
	%VisionRightPeriph.rotate(PI/8)
	%VisionLeftPeriph.rotate(-PI/8)
	%VisionRightPeriph2.rotate(PI/4)
	%VisionLeftPeriph2.rotate(-PI/4)
	%VisionRightPeriph3.rotate(PI*0.375)
	%VisionLeftPeriph3.rotate(-PI*0.375)
	var VisionTemp = [%VisionRightPeriph,%VisionRightPeriph2,%VisionRightPeriph3,%VisionLeftPeriph,%VisionLeftPeriph2,%VisionLeftPeriph3,%VisionCenter]
	Vision.append_array(VisionTemp)

func _ready():
	#SignalBus.connect("cameraRotated", Callable(self, "_on_camera_2d_new_camera_rotated"))
	vision_baseline()

func _process(delta):
	#if headScanning == true: scanning()
	retargetCD -= TimeManager.bulletTime
	retargetCD = clampf(retargetCD, 0.0, 2.0)
	notice_enemy()
	if EnemyManager.EnemiesNoticed.size() > 0 and retargetCD == 0.0:
		EnemyManager.sort_enemies_by_importance(EnemyManager.EnemiesNoticed) 
		var target = EnemyManager.EnemiesNoticed[0]
		for enemy in EnemyManager.EnemiesNoticed:
			if enemy.is_in_group("Enemy") and enemy not in EnemyManager.EnemiesOutOfReach:
				target = enemy
				break
		
		turn_to_enemy(target)
		retargetCD += 2.0
		
		#debugging stuff
		#if target: target.modulate  = Color(1, 0, 0, 0.7)
		#
		#for enemy in EnemyManager.EnemiesNoticed:
			#if enemy != target: enemy.modulate  = Color(1, 1, 1, 1)
		#
		#print(target)
	
	##trying to implement field of vision
	#var pos = self.global_position
	#direction = Movement.orientation
	#angle = 90 - rad_to_deg(direction.angle())
	#
	#for enemy in EnemyManager.get_enemies():
		#enemy_direction = (enemy.global_position - self.global_position).normalized()
		#if pos.distance_to(enemy.global_position) < detectRadius:
			#var angle_to_node = rad_to_deg(direction.angle_to(enemy_direction))
			#if abs(angle_to_node) < FOV/2: #if enemy is visible
				#enemy.modulate.a = min(1,enemy.modulate.a + delta * TimeManager.gameSpeed * 2)
			#else:
				#enemy.modulate.a = max(0.0,enemy.modulate.a - delta * TimeManager.gameSpeed)
	




#func _on_camera_2d_new_camera_rotated(turning):
	#if turningTween: turningTween.stop()
	#if turning == "right":
		#print("boing")
		#cameraRotationTween = create_tween()
		#cameraRotationTween.tween_property(%HeadAS2,"rotation",%HeadAS2.rotation+PI/2,0.5).set_trans(Movement.styleTween)
	#elif turning == "left":
		#print("boing")
		#cameraRotationTween = create_tween()
		#cameraRotationTween.tween_property(%HeadAS2,"rotation",%HeadAS2.rotation-PI/2,0.5).set_trans(Movement.styleTween)
