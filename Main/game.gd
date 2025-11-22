extends Node2D

var CharBodyNode
var RightShoeNode
var LeftShoeNode

var gameSpeed

var enemy_count = 0
var spawnerArray: Array = []

func spawn_bullet():
	var new_bullet = preload("res://Weapons/bullet_new.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bullet.global_position = %PathFollow2D.global_position + Movement.midpoint
	new_bullet.look_at(Movement.midpoint)
	new_bullet.bulletSpeed = randf_range(0.75*new_bullet.bulletSpeed,1.5*new_bullet.bulletSpeed)
	add_child(new_bullet)

func spawn_enemy():
	var new_enemy = preload("res://Enemies/enemy.tscn").instantiate()
	var randSpawn = spawnerArray.pick_random()
	if randSpawn == $Spawners/Spawner1 or randSpawn == $Spawners/Spawner4: new_enemy.strafeBool = true
	elif randSpawn == $Spawners/Spawner2 or randSpawn == $Spawners/Spawner3: new_enemy.strafeBool = false
	else: new_enemy.strafeBool = randf() < 0.5
	new_enemy.global_position = randSpawn.global_position
	if enemy_count < 5:
		add_child(new_enemy)

func spawn_player():
	var character
	if Global.character == "Drone_A": character = preload("res://Character/drone_a.tscn").instantiate()
	elif Global.character == "Drone_B": character = preload("res://Character/drone_b.tscn").instantiate()
	elif Global.character == "Rogue_B": character = preload("res://Character/rogue_b.tscn").instantiate()
	add_child(character)


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
	spawn_player()
	
	var SpawnerTemp = [$Spawners/Spawner1,$Spawners/Spawner2,$Spawners/Spawner3,$Spawners/Spawner4]
	spawnerArray.append_array(SpawnerTemp)
	
	if Global.gameMode == 1:
		$BulletSpawnTime.wait_time *= 10
		$SlomoBulletSpawnTime.wait_time *= 10

func _process(_delta):
	
	enemy_count = 0
	for child in get_children():
		if child.has_meta("Enemy"):
			enemy_count += 1
	
	if TimeManager.gameSpeed == TimeManager.bulletTime:
		$BulletSpawnTime.set_paused(1)
		$SlomoBulletSpawnTime.set_paused(0)
	elif TimeManager.gameSpeed == TimeManager.normalTime:
		$SlomoBulletSpawnTime.set_paused(1)
		$BulletSpawnTime.set_paused(0)
		
	
	#if Global.currentExp >= Global.expToLevel:
		#Global.currentExp -= Global.expToLevel
		#get_tree().paused = true
		#%CharacterBody2D/CharBody/Marker2D/Camera2D/LevelUpScreen.show()
		

	
func _input(event):
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
