extends Node2D

var target = Vector2.ZERO

func update_positions():
	target = get_global_mouse_position()
	self.global_position = target
	

func _process(delta):
	update_positions()


func _input(event):
	if event.is_action_pressed("LeftMouse"): WeaponManager.shoot(%GunLeft)
	if event.is_action_pressed("RightMouse"): WeaponManager.shoot(%GunRight)
