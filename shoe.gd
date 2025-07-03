extends CharacterBody2D

const SPEED = 150
const DISTANCE = 32
var starting_position_x = global_position.x
var starting_position_y = global_position.y
var target_position_x
var target_position_y


func _physics_process(delta: float) -> void:
	if velocity.x == 0 and velocity.y == 0:
		if Input.is_action_just_pressed("RS_move_left"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.x -= SPEED
			target_position_x = starting_position_x - DISTANCE
			target_position_y = starting_position_y
		if Input.is_action_just_pressed("RS_move_right"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.x += SPEED
			target_position_x = starting_position_x + DISTANCE
			target_position_y = starting_position_y
		if Input.is_action_just_pressed("RS_move_up"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.y -= SPEED
			target_position_x = starting_position_x
			target_position_y = starting_position_y - DISTANCE
		if Input.is_action_just_pressed("RS_move_down"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.y += SPEED
			target_position_x = starting_position_x
			target_position_y = starting_position_y + DISTANCE
		if Input.is_action_just_pressed("RS_move_leftup"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.x -= SPEED
			velocity.y -= SPEED
			target_position_x = starting_position_x - DISTANCE
			target_position_y = starting_position_y - DISTANCE
		if Input.is_action_just_pressed("RS_move_rightup"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.x += SPEED
			velocity.y -= SPEED
			target_position_x = starting_position_x + DISTANCE
			target_position_y = starting_position_y - DISTANCE
		if Input.is_action_just_pressed("RS_move_leftdown"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.x -= SPEED
			velocity.y += SPEED
			target_position_x = starting_position_x - DISTANCE
			target_position_y = starting_position_y + DISTANCE
		if Input.is_action_just_pressed("RS_move_rightdown"):
			starting_position_x = global_position.x
			starting_position_y = global_position.y
			velocity.x += SPEED
			velocity.y += SPEED
			target_position_x = starting_position_x + DISTANCE
			target_position_y = starting_position_y + DISTANCE
	
	if global_position.x >= starting_position_x + DISTANCE-1:
		velocity.x = 0
	if global_position.x <= starting_position_x - DISTANCE+1:
		velocity.x = 0
	if global_position.y >= starting_position_y + DISTANCE-1:
		velocity.y = 0
	if global_position.y <= starting_position_y - DISTANCE+1:
		velocity.y = 0
	
	print(target_position_x,",",target_position_y)
	
	move_and_slide()
