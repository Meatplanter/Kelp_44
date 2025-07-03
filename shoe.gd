extends CharacterBody2D

const distance = 32



func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("RS_move_left"):
		velocity.x -= distance
	if Input.is_action_just_pressed("RS_move_right"):
		velocity.x += distance
	if Input.is_action_just_pressed("RS_move_up"):
		velocity.y -= distance
	if Input.is_action_just_pressed("RS_move_down"):
		velocity.y += distance
	if Input.is_action_just_pressed("RS_move_leftup"):
		velocity.x -= distance
		velocity.y -= distance
	if Input.is_action_just_pressed("RS_move_rightup"):
		velocity.x += distance
		velocity.y -= distance
	if Input.is_action_just_pressed("RS_move_leftdown"):
		velocity.x -= distance
		velocity.y += distance
	if Input.is_action_just_pressed("RS_move_rightdown"):
		velocity.x += distance
		velocity.y += distance
		
		print("test")
	move_and_slide()
