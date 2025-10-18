extends Node2D

#AimingStlye1: Aim with your mouse. 
#Shoot left gun with left mouse button, right with right mouse button

var target = Vector2.ZERO

func update_positions():
	target = get_global_mouse_position()
	self.global_position = target


func cooldown_color():
	if %GunLeft: 
		if %GunLeft.cooldown >= 0: %GunLeft/WeaponPivot/Revolver.self_modulate = Color.RED
		else: %GunLeft/WeaponPivot/Revolver.self_modulate = Color.WHITE
	if %GunRight: 
		if %GunRight.cooldown >= 0: %GunRight/WeaponPivot/Revolver.self_modulate = Color.RED
		else: %GunRight/WeaponPivot/Revolver.self_modulate = Color.WHITE



func _ready():
	if %GunLeft: %GunLeft.Laser_sights = true
	if %GunRight: %GunRight.Laser_sights = true
	if Global.gameMode == 0 and get_parent().is_in_group("Player"): self.hide()

func _process(delta):
	update_positions()
	cooldown_color()


func _input(event):
	if event.is_action_pressed("LeftMouse") and %GunLeft.cooldown <= 0:
		WeaponManager.shoot(%GunLeft)
		%GunLeft.cooldown = randf_range(0.98,1.02)
	if event.is_action_pressed("RightMouse") and %GunRight.cooldown <= 0:
		WeaponManager.shoot(%GunRight)
		%GunRight.cooldown = randf_range(0.98,1.02)
