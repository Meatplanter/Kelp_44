extends Area2D

var cameraRotationTween: Tween
var scanningTween: Tween
var memorizingTween: Tween

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
@export var detectRadius = 2000
var FOV = 220

var Vision: Array = []
var headState = "Scanning"
var scanningRight = true #false means scanning left

#var EnemyManager.EnemiesNoticed: Array = []
#var EnemyManager.EnemiesMemorized: Array = []

var untilMemorized = 100.0
var losingFocus = 100.0

#func stop_rotating_when_moving():
	#if TimeManager.gameSpeed == TimeManager.normalTime:
		#if scanningTween: scanningTween.pause()
		#if memorizingTween: memorizingTween.pause()
	#elif TimeManager.gameSpeed == TimeManager.bulletTime:
		#if scanningTween: scanningTween.play()
		#if memorizingTween: memorizingTween.play()


func reset_to_scanning():
	if scanningTween: scanningTween.play()
	headState = "Scanning"
	untilMemorized = 100.0
	losingFocus = 100.0


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
			if collider and collider.is_in_group("Enemy") and collider.enemyState == "Unnoticed":
				collider.enemyState = "Noticed"
				EnemyManager.EnemiesNoticed.append(collider)

func memorize_enemy(target):
	if scanningTween: scanningTween.pause()
	headState = "Memorizing"
	var headOrientation = (to_global(%VisionCenter.target_position) - %HeadAS2.global_position).normalized()
	var targetOrientation = (target.global_position - %HeadAS2.global_position).normalized()
	var angleTo = rad_to_deg(headOrientation.angle_to(targetOrientation))
	var targetAngle = clampf(%HeadAS2.rotation_degrees + angleTo,Movement.cumulativeAngle - 90,Movement.cumulativeAngle + 90)
	memorizingTween = create_tween()
	memorizingTween.tween_property(%HeadAS2,"rotation_degrees",targetAngle, 0.3 / TimeManager.gameSpeed)
	if %VisionCenter.is_colliding() and %VisionCenter.get_collider() == target:
		untilMemorized -= TimeManager.gameSpeed
	else: 
		losingFocus -= TimeManager.gameSpeed
		
	if untilMemorized < 0: 
		target.enemyState = "Memorized"
		EnemyManager.EnemiesNoticed.erase(target)
		EnemyManager.EnemiesMemorized.append(target)
		reset_to_scanning()
	if losingFocus < 0:
		target.enemyState = "Dropped"
		EnemyManager.EnemiesNoticed.erase(target)
		reset_to_scanning()
	#print("until memorized ",untilMemorized,"  losing focus: ",losingFocus,"  dropoff: ",target.droppedFalloff)

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
	EnemyManager.get_visible_enemies()
	if headState == "Scanning": scanning()
	notice_enemy()
	if EnemyManager.EnemiesNoticed.size() > 0: memorize_enemy(EnemyManager.EnemiesNoticed.front())
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
