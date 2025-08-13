extends CharacterBody2D

@onready var playerLocation = get_node("/root/Game/CharacterBody2D/CharBody")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = global_position.direction_to(playerLocation.midpoint)
	if global_position.distance_to(playerLocation.midpoint) > 150:
		velocity = direction * Global.gameSpeed * 30.0
	else:
		velocity = direction * 0.0
	move_and_slide()
