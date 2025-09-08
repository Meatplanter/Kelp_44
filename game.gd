extends Node2D

var CharBodyNode
var RightShoeNode
var LeftShoeNode

var gameSpeed

var enemy_count = 0

func spawn_bullet():
	var new_bullet = preload("res://Bullet.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bullet.global_position = %PathFollow2D.global_position
	new_bullet.look_at(Global.CharBodyNode.midpoint)
	add_child(new_bullet)

func spawn_enemy():
	var new_enemy = preload("res://enemy.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_enemy.global_position = %PathFollow2D.global_position
	if enemy_count < 5:
		add_child(new_enemy)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

#func _draw():
	#draw_circle(Vector2(EnemyManager.minX,EnemyManager.minY),10,Color.RED)
	#draw_circle(Vector2(EnemyManager.maxX,EnemyManager.maxY),10,Color.RED)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	queue_redraw()
	
	enemy_count = 0
	for child in get_children():
		if child.has_meta("Enemy"):
			enemy_count += 1
	if Global.leftMoving == false && Global.rightMoving == false:
		Global.canMove = true
	else:
		Global.canMove = false
	
	if Global.canMove == true:
		gameSpeed = Global.bulletTime
		$BulletSpawnTime.set_paused(1)
		$SlomoBulletSpawnTime.set_paused(0)
	else:
		gameSpeed = Global.normalTime
		$SlomoBulletSpawnTime.set_paused(1)
		$BulletSpawnTime.set_paused(0)
	Global.gameSpeed = gameSpeed
	
	if Global.leftWeighted == true && Global.rightWeighted == true:
		Global.weightedShoe = "both"
	elif Global.leftWeighted == true && Global.rightWeighted == false:
		Global.weightedShoe = "left"
	elif Global.leftWeighted == false && Global.rightWeighted == true:
		Global.weightedShoe = "right"
		

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ChangeMode") && Global.gameMode == 0:
		Global.gameMode = 1
		print("Mode is now: Spawn enemies")
	elif event.is_action_pressed("ChangeMode") && Global.gameMode == 1:
		Global.gameMode = 0
		print("Mode is now: Spawn bullets")
		

func _on_bullet_spawn_time_timeout() -> void:
	if Global.gameMode == 0:
		spawn_bullet()
	elif Global.gameMode == 1:
		spawn_enemy()

func _on_slomo_bullet_spawn_time_timeout() -> void:
	if Global.gameMode == 0:
		spawn_bullet()
	elif Global.gameMode == 1:
		spawn_enemy()
