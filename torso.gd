extends CharacterBody2D

var tween: Tween
var move_speed: float = 50.0 * Global.gameSpeed

func _process(delta: float) -> void:
	look_at(Global.focus)
	rotate(PI/2)
	

func _physics_process(delta: float) -> void:
	var target_position: Vector2

	match Global.weightedShoe:
		"both":
			target_position = Global.midpoint
		"left":
			target_position = (Global.midpoint + %LeftShoe.global_position) / 2
		"right":
			target_position = (Global.midpoint + %RightShoe.global_position) / 2

	global_position = global_position.move_toward(target_position, move_speed * delta)
