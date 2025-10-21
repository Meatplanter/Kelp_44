extends Node2D

var parent
var speed = 20.0
var movementCD = 0.5
var absVelocity = Vector2.ZERO
var canMove = true

func _ready():
	parent = get_parent()

func _physics_process(delta):
	parent.velocity = absVelocity * TimeManager.gameSpeed
	absVelocity *= 0.999

func move(parent: Node2D, direction: Vector2, speed: float):
	if canMove == true: 
		absVelocity += speed * direction
		canMove = false
		TimeManager.gameSpeed = TimeManager.normalTime
		await get_tree().create_timer(movementCD).timeout
		TimeManager.gameSpeed = TimeManager.bulletTime
		canMove = true

func _input(event):
	if event.is_action_pressed("LS_move_left"): move(parent,Vector2.LEFT,speed)
	elif event.is_action_pressed("LS_move_right"): move(parent,Vector2.RIGHT,speed)
	elif event.is_action_pressed("LS_move_up"): move(parent,Vector2.UP,speed)
	elif event.is_action_pressed("AimLeftGun [S]"): move(parent,Vector2.DOWN,speed)
