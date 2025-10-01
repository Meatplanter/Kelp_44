extends Node

var weaponCooldown = 10.0

var leftCooldown = weaponCooldown
var rightCooldown = weaponCooldown

var targetEnemyLeft = EnemyManager.targetEnemyLeft
var targetEnemyRight = EnemyManager.targetEnemyRight

var shootingPoint = Vector2.ZERO


func shoot():
	const BULLET = preload("res://Bullet.tscn")
	var new_bullet = BULLET.instantiate()
	new_bullet.global_position = Vector2(50,-50)
	new_bullet.global_rotation = PI/2
	get_tree().get_current_scene().add_child(new_bullet)
	#new_bullet.global_position = %ShootingPoint.global_position
	#new_bullet.global_rotation = get_parent().global_rotation
