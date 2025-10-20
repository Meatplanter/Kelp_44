extends CharacterBody2D

var health = EnemyManager.enemyHealth
var firerate = EnemyManager.enemyFirerate

var strafeBool = true

func chase_player():
	var direction = global_position.direction_to(Movement.midpoint)
	velocity = direction * TimeManager.gameSpeed * 30.0

func strafe(clockwise: bool):
	var direction
	if clockwise == true:
		direction = global_position.direction_to(Movement.midpoint).rotated(PI/2)
	elif clockwise == false:
		direction = global_position.direction_to(Movement.midpoint).rotated(-PI/2)
	velocity = direction * TimeManager.gameSpeed * 30.0

func _ready() -> void:
	EnemyManager.register_enemy(self)
	strafeBool = randf() < 0.5
	firerate = randf_range(firerate*0.75,firerate*1.5)
	%GunNew.Firerate = firerate


func _process(delta: float) -> void:
	look_at(Movement.midpoint)
	if global_position.distance_to(Movement.midpoint) > 300: 
		chase_player()
	else:
		strafe(strafeBool)
	
	move_and_slide()

func take_damage():
	health -= 1
	if health == 0:
		Global.enemiesKilled += 1
		queue_free()
		if Global.gameMode == 1:
			Global.currentExp += Global.xp4enemy

func _exit_tree():
	EnemyManager.unregister_enemy(self)
