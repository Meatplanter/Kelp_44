extends Node2D

var CharBodyNode
var RightShoeNode
var LeftShoeNode

var gameSpeed = 1.0

func spawn_bullet():
	var new_bullet = preload("res://Bullet.tscn").instantiate()
	%PathFollow2D.progress_ratio = randf()
	new_bullet.global_position = %PathFollow2D.global_position
	new_bullet.look_at(Global.CharBodyNode.midpoint)
	add_child(new_bullet)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.LeftShoeNode.canMove == true && Global.RightShoeNode.canMove == true:
		gameSpeed = 0.1
		$BulletSpawnTime.set_paused(1)
		$SlomoBulletSpawnTime.set_paused(0)
	else:
		gameSpeed = 1.0
		$SlomoBulletSpawnTime.set_paused(1)
		$BulletSpawnTime.set_paused(0)
	Global.gameSpeed = gameSpeed

func _on_bullet_spawn_time_timeout() -> void:
	spawn_bullet()

func _on_slomo_bullet_spawn_time_timeout() -> void:
	spawn_bullet()
