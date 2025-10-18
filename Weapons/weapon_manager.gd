extends Node


var shootingPoint = Vector2.ZERO

#bullet's defaults
var bulletSpeed = 120
var bulletRange = 700
var bulletSlowdown = 0.998

var bloodTrailVisible = true
var bloodTrailScene = false #true is pixels, false is sprite


func shoot(Gun:Node2D):
	const BULLET = preload("res://Weapons/bullet_new.tscn")
	var new_bullet = BULLET.instantiate()
	var shooting_point = Gun.get_node("%ShootingPoint")
	new_bullet.global_position = shooting_point.global_position
	new_bullet.global_rotation = Gun.global_rotation
	get_tree().get_current_scene().add_child(new_bullet)
	new_bullet.bulletSpeed = Gun.Bullet_speed
