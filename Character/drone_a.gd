extends CharacterBody2D

func _physics_process(_delta):
	Movement.midpoint = global_position
	move_and_slide()
