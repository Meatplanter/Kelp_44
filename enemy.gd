extends CharacterBody2D

var health = Global.enemyHealth

@onready var playerLocation = get_node("/root/Game/CharacterBody2D/CharBody")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	look_at(Global.midpoint)
	var direction = global_position.direction_to(playerLocation.midpoint)
	if global_position.distance_to(playerLocation.midpoint) > 300:
		velocity = direction * Global.gameSpeed * 30.0
	else:
		velocity = direction * 0.0
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		Global.enemiesKilled += 1
		queue_free()
