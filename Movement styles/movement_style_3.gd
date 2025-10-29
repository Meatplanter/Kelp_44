extends Node2D

#MovementStyle2: Get a velocity increase while you hold a button

var parent
var speed = 1
var absVelocity = Vector2.ZERO

func _ready():
	parent = get_parent()

func _physics_process(_delta):
	var direction = Input.get_vector("LS_move_left","LS_move_right","LS_move_up","AimLeftGun [S]")
	if direction == Vector2.ZERO: TimeManager.gameSpeed = TimeManager.bulletTime
	else: TimeManager.gameSpeed = TimeManager.normalTime
	absVelocity += direction * speed
	parent.velocity = absVelocity * TimeManager.gameSpeed
	absVelocity *= 0.999
