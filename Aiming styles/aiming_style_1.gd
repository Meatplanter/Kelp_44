extends Node2D

#AimingStlye1: Aim with your mouse. 
#Shoot left gun with left mouse button, right with right mouse button

var target = Vector2.ZERO

func gun_rotation(joint: Node2D, target: Vector2, duration: float):
	var targetAngle = (target - joint.global_position).angle()
	
	targetAngle = lerp_angle(joint.rotation,targetAngle,1.0)
	targetAngle = clamp(targetAngle,deg_to_rad(Movement.cumulativeAngle),deg_to_rad(Movement.cumulativeAngle))
	
	var tween: Tween
	tween = create_tween()
	tween.tween_property(joint,"rotation",targetAngle,duration / TimeManager.gameSpeed).set_ease(Tween.EASE_OUT_IN)

func target_chase_mouse():
	var center = get_parent().global_position
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - center).normalized()
	
	if get_parent().is_in_group("Drone"): #this limits the max range of invisible target, so that it doesn't act too weird when aiming without crosshair
		target = center + direction * 100
	else:
		target = mouse_pos
	
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%Target,"global_position",target,0.5 / TimeManager.gameSpeed)#.set_trans(Movement.styleTween)

func update_positions():
	#target = get_global_mouse_position()
	#%Target.global_position = target
	AimingManager.targetLeft = %Target.global_position
	AimingManager.targetRight = %Target.global_position
	
	if %HeadNew: %HeadNew.global_position = AimingManager.neck
	
	if get_parent().is_in_group("Drone"): 
		if get_parent().has_node("GunLeft"): 
			%GunLeft.look_at(%Target.global_position)
		if get_parent().has_node("GunRight"): 
			%GunRight.look_at(%Target.global_position)


func cooldown_color():
	if get_parent().has_node("GunLeft"): 
		if %GunLeft.cooldown >= 0: %GunLeft/WeaponPivot/Revolver.self_modulate = Color.RED
		else: %GunLeft/WeaponPivot/Revolver.self_modulate = Color.WHITE
	if get_parent().has_node("GunRight"): 
		if %GunRight.cooldown >= 0: %GunRight/WeaponPivot/Revolver.self_modulate = Color.RED
		else: %GunRight/WeaponPivot/Revolver.self_modulate = Color.WHITE


func _ready():
	if get_parent().has_node("GunLeft"): 
		%GunLeft.Laser_sights = true
		AimingManager.targetLeft = Vector2.ZERO
	if get_parent().has_node("GunRight"):
		%GunRight.Laser_sights = true
		AimingManager.targetRight = Vector2.ZERO
	if Global.gameMode == 0 and get_parent().is_in_group("Player"): %Target.hide()
	if get_parent().is_in_group("Drone"): %Target.hide()


func _process(delta):
	update_positions()
	target_chase_mouse()
	cooldown_color()

func _input(event):
	if get_parent().has_node("GunLeft") and event.is_action_pressed("LeftMouse") and %GunLeft.cooldown <= 0:
		WeaponManager.shoot(%GunLeft)
		%GunLeft.cooldown = randf_range(0.98,1.02)
	if get_parent().has_node("GunRight") and event.is_action_pressed("RightMouse") and %GunRight.cooldown <= 0:
		WeaponManager.shoot(%GunRight)
		%GunRight.cooldown = randf_range(0.98,1.02)
