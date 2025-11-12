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
var headScanning = true #head is searching for a new enemy
var scanningRight = true #false means scanning left



func reset_to_scanning():
	if scanningTween: scanningTween.play()
	headScanning = true


func scanning():
	if %HeadAS2.rotation_degrees > Movement.cumulativeAngle + 45: scanningRight = false
	elif %HeadAS2.rotation_degrees < Movement.cumulativeAngle - 45: scanningRight = true
	
	if scanningRight == true:
		scanningTween = create_tween()
		scanningTween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle + 60, 1 / TimeManager.gameSpeed)
	elif scanningRight == false:
		scanningTween = create_tween()
		scanningTween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle - 60, 1 / TimeManager.gameSpeed)

func notice_enemy():
	for ray in Vision:
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and collider.is_in_group("Enemy"): #gain attention while looked at
				collider.attention += TimeManager.gameSpeed
				collider.lastNoticed = 25.0
	
	#reset who is being looked at, so that it can be established below
	if EnemyManager.EnemiesNoticed.is_empty():
		return null
	else:
		for enemy in EnemyManager.EnemiesNoticed:
			enemy.beingLookedAt = false
	
	if %VisionCenter.is_colliding():
		var collider = %VisionCenter.get_collider()
		if collider and collider.is_in_group("Enemy"):
			collider.attention += TimeManager.gameSpeed * 2 #triple the speed of gaining attention when looked at directly
			collider.beingLookedAt = true
			if collider.attention >= 100.0: collider.lastMemorized += TimeManager.gameSpeed * 2 #prolong the grace period, so you don't start forgetting the enemy you're accidentaly looking at
			

func get_enemy_with_highest(stat): #stat: fear, attention, threat. Returns null if all are 0. 
	if EnemyManager.EnemiesNoticed.is_empty():
		return null
		
	var highest_enemy = null
	var highest_stat = 0.0
	
	for enemy in EnemyManager.EnemiesNoticed:
		if enemy.get(stat) > highest_stat:
			highest_enemy = enemy
			highest_stat = enemy.get(stat)
			
	return highest_enemy


func turn_to_enemy(target):
	if scanningTween: scanningTween.pause()
	headScanning = false
	
	var headOrientation = (to_global(%VisionCenter.target_position) - %HeadAS2.global_position).normalized()
	var targetOrientation = (target.global_position - %HeadAS2.global_position).normalized()
	var angleTo = rad_to_deg(headOrientation.angle_to(targetOrientation))
	var targetAngle = clampf(%HeadAS2.rotation_degrees + angleTo,Movement.cumulativeAngle - 90,Movement.cumulativeAngle + 90)
	turningTween = create_tween()
	turningTween.tween_property(%HeadAS2,"rotation_degrees",targetAngle, 0.3 / TimeManager.gameSpeed)

func remember_enemy():
	for ray in Vision:
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and collider.is_in_group("Enemy") and collider.enemyState == "Memorized":
				collider.stillMemorized = 100.0
				

func forget_enemy():
	for enemy in EnemyManager.EnemiesNoticed:
		if enemy.enemyState == "Unnoticed":
			EnemyManager.EnemiesNoticed.erase(enemy)
	for enemy in EnemyManager.EnemiesMemorized:
		if enemy.enemyState == "Unnoticed":
			EnemyManager.EnemiesMemorized.erase(enemy)

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
	if headScanning == true: scanning()
	notice_enemy()
	if EnemyManager.EnemiesNoticed.size() > 0:
		var topEnemy
		if get_enemy_with_highest("fear") != null:
			topEnemy = get_enemy_with_highest("fear")
		elif get_enemy_with_highest("fear") == null:
			for enemy in EnemyManager.EnemiesNoticed:
				if enemy.beingLookedAt == true and enemy.attention < 100:
					topEnemy = enemy
				else:
					topEnemy = get_enemy_with_highest("attention")
		turn_to_enemy(topEnemy)
	else: #got to make exception for enemies with 100 attention, so that the scanning occurs
		reset_to_scanning()
	
	remember_enemy()
	forget_enemy()
	
	
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
