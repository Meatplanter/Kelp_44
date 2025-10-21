extends CharacterBody2D

func _physics_process(delta):
	Movement.midpoint = global_position
	move_and_slide()
