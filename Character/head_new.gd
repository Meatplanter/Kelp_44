extends Area2D

var tween: Tween

var crosshair = preload("res://Visuals/crosshair.tscn")

var direction = Vector2()
var enemy_direction = Vector2()
var angle = 0
const DETECT_RADIUS = 2000
const FOV = 220

func _ready():
	if get_parent().get_parent().is_in_group("Drone"):hide()
	SignalBus.connect("cameraRotated", Callable(self, "_on_camera_2d_new_camera_rotated"))

func _process(delta):
	EnemyManager.enemy_scope()
	EnemyManager.get_visible_enemies()
	
	#trying to implement field of vision
	var pos = Movement.midpoint
	direction = (Movement.focus - Movement.midpoint).normalized()
	angle = 90 - rad_to_deg(direction.angle())
	
	for enemy in EnemyManager.get_enemies():
		enemy_direction = (enemy.global_position - Movement.midpoint).normalized()
		if pos.distance_to(enemy.global_position) < DETECT_RADIUS:
			var angle_to_node = rad_to_deg(direction.angle_to(enemy_direction))
			if abs(angle_to_node) < FOV/2: #if enemy is visible
				enemy.modulate.a = min(1,enemy.modulate.a + delta * TimeManager.gameSpeed * 2)
			else:
				enemy.modulate.a = max(0.0,enemy.modulate.a - delta * TimeManager.gameSpeed)



func _on_camera_2d_new_camera_rotated(turning):
	if turning == "right":
		tween = create_tween()
		tween.tween_property(%HeadNew,"rotation",%HeadNew.rotation+PI/2,0.5).set_trans(Movement.styleTween)
	if turning == "left":
		tween = create_tween()
		tween.tween_property(%HeadNew,"rotation",%HeadNew.rotation-PI/2,0.5).set_trans(Movement.styleTween)
