extends Area2D

var tween: Tween

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
const DETECT_RADIUS = 2000
var FOV = 220

var scanningRight = true #false means scanning left

func scanning():
	if %HeadAS2.rotation_degrees > Movement.cumulativeAngle + 45: scanningRight = false
	elif %HeadAS2.rotation_degrees < Movement.cumulativeAngle - 45: scanningRight = true
	
	if scanningRight == true:
		tween = create_tween()
		tween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle + 60, 1 / TimeManager.gameSpeed)
	elif scanningRight == false:
		tween = create_tween()
		tween.tween_property(%HeadAS2,"rotation_degrees",Movement.cumulativeAngle - 60, 1 / TimeManager.gameSpeed)

func _ready():
	SignalBus.connect("cameraRotated", Callable(self, "_on_camera_2d_new_camera_rotated"))
	%VisionRightPeriph.rotate(PI/4)
	%VisionLeftPeriph.rotate(-PI/4)
	%VisionRightPeriph2.rotate(PI/8)
	%VisionLeftPeriph2.rotate(-PI/8)

func _process(delta):
	EnemyManager.get_visible_enemies()
	scanning()
	
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
