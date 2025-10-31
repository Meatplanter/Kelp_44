extends Area2D

var tween: Tween

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
const DETECT_RADIUS = 2000
var FOV = 220

var x = 0

var Vision: Array = []
var headState = "Scanning"
var scanningRight = true #false means scanning left

func find_angle_between(pointA:Node2D, middle: Node2D, pointB: Node2D):
	var lineA = (pointA.global_position - middle.global_position).normalized()
	var lineB = (pointB.global_position - middle.global_position).normalized()
	var angle = rad_to_deg(lineA.angle_to(lineB))
	return angle


func scanning():
	if %HeadAS2.rotation_degrees > Movement.cumulativeAngle + 45: scanningRight = false
	elif %HeadAS2.rotation_degrees < Movement.cumulativeAngle - 45: scanningRight = true
	
	if scanningRight == true:
		tween = create_tween()
		tween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle + 60, 1 / TimeManager.gameSpeed)
	elif scanningRight == false:
		tween = create_tween()
		tween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle - 60, 1 / TimeManager.gameSpeed)

func notice_enemy():
	for ray in Vision:
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and collider.is_in_group("Enemy") and collider.enemyState == "Unnoticed":
				collider.enemyState = "Noticed"

func memorize_enemy():
	var enemies = EnemyManager.get_visible_enemies()
	if headState == "Scanning":
		for enemy in enemies:
			if enemy.enemyState == "Noticed":
				headState = "Memorizing"
				var headOrientation = (to_global(%VisionCenter.target_position) - %HeadAS2.global_position).normalized()
				var targetOrientation = (enemy.global_position - %HeadAS2.global_position).normalized()
				var angleTo = rad_to_deg(headOrientation.angle_to(targetOrientation))
				tween.kill()
				tween = create_tween()
				tween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle + angleTo, 0.5 / TimeManager.gameSpeed)
				await get_tree().create_timer(1 / TimeManager.gameSpeed).timeout
				enemy.enemyState = "Memorized"
				headState = "Scanning"

func _ready():
	SignalBus.connect("cameraRotated", Callable(self, "_on_camera_2d_new_camera_rotated"))
	%VisionRightPeriph.rotate(PI/4)
	%VisionLeftPeriph.rotate(-PI/4)
	%VisionRightPeriph2.rotate(PI/8)
	%VisionLeftPeriph2.rotate(-PI/8)
	var VisionTemp = [%VisionRightPeriph,%VisionRightPeriph2,%VisionLeftPeriph,%VisionLeftPeriph2,%VisionCenter]
	Vision.append_array(VisionTemp)

func _process(delta):
	EnemyManager.get_visible_enemies()
	if headState == "Scanning": 
		scanning()
		x += 1
		print(x)
	notice_enemy()
	memorize_enemy()
	#print(headState)
	
	
	#trying to implement field of vision
	var pos = self.global_position
	direction = Movement.orientation
	angle = 90 - rad_to_deg(direction.angle())
	
	for enemy in EnemyManager.get_enemies():
		enemy_direction = (enemy.global_position - self.global_position).normalized()
		if pos.distance_to(enemy.global_position) < DETECT_RADIUS:
			var angle_to_node = rad_to_deg(direction.angle_to(enemy_direction))
			if abs(angle_to_node) < FOV/2: #if enemy is visible
				enemy.modulate.a = min(1,enemy.modulate.a + delta * TimeManager.gameSpeed * 2)
			else:
				enemy.modulate.a = max(0.0,enemy.modulate.a - delta * TimeManager.gameSpeed)
	




func _on_camera_2d_new_camera_rotated(turning):
	if turning == "right":
		tween = create_tween()
		tween.tween_property(%HeadAS2,"rotation",%HeadAS2.rotation+PI/2,0.5).set_trans(Movement.styleTween)
	if turning == "left":
		tween = create_tween()
		tween.tween_property(%HeadAS2,"rotation",%HeadAS2.rotation-PI/2,0.5).set_trans(Movement.styleTween)
