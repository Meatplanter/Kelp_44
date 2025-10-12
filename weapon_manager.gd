extends Node

var weaponCooldown = 10.0

var leftCooldown = weaponCooldown
var rightCooldown = weaponCooldown

var targetEnemyLeft = EnemyManager.targetEnemyLeft
var targetEnemyRight = EnemyManager.targetEnemyRight

var shootingPoint = Vector2.ZERO

func shoot(Gun:Node2D):
	const BULLET = preload("res://bullet_new.tscn")
	var new_bullet = BULLET.instantiate()
	var shooting_point = Gun.get_node("%ShootingPoint")
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = Gun.global_rotation
	get_tree().get_current_scene().add_child(new_bullet)
	new_bullet.bulletSpeed = Gun.Bullet_speed
