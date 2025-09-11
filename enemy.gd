extends CharacterBody2D

var health = Global.enemyHealth

@onready var playerLocation = get_node("/root/Game/CharacterBody2D/CharBody")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	EnemyManager.register_enemy(self)
	



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if EnemyManager.targetEnemyLeft == self && Global.leftCanShoot == true:
		$Crosshair_greenLeft.show()
		$CrosshairLeft.hide()
	elif EnemyManager.targetEnemyLeft == self && Global.leftCanShoot == false:
		$Crosshair_greenLeft.hide()
		$CrosshairLeft.show()
	else:
		$Crosshair_greenLeft.hide()
		$CrosshairLeft.hide()
		
	if EnemyManager.targetEnemyRight == self && Global.rightCanShoot == true:
		$Crosshair_greenRight.show()
		$CrosshairRight.hide()
	elif EnemyManager.targetEnemyRight == self && Global.rightCanShoot == false:
		$Crosshair_greenRight.hide()
		$CrosshairRight.show()
	else:
		$Crosshair_greenRight.hide()
		$CrosshairRight.hide()
	
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
		if Global.gameMode == 1:
			Global.currentExp += Global.xp4enemy

func _exit_tree():
	EnemyManager.unregister_enemy(self)
