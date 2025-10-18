extends CharacterBody2D

var health = EnemyManager.enemyHealth
var firerate = EnemyManager.enemyFirerate

func _ready() -> void:
	EnemyManager.register_enemy(self)
	firerate = randf_range(firerate*0.75,firerate*1.5)
	%GunNew.Firerate = firerate

func _process(delta: float) -> void:
	
	look_at(Movement.midpoint)
	var direction = global_position.direction_to(Movement.midpoint)
	if global_position.distance_to(Movement.midpoint) > 300:
		velocity = direction * TimeManager.gameSpeed * 30.0
	else:
		velocity = direction * 0.0
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
