extends Node2D

@export var Laser_sights := false
@export var Firerate := 1.0
@export var Bullet_speed := 120.0

var cooldown = Firerate
var canShoot = true

func aiming_at():
	if %LaserSights.is_colliding():
		var collider = %LaserSights.get_collider()
		return collider


func _draw():
	if Laser_sights == true:
		var ray = %LaserSights
		
		var aimFrom = to_local(ray.global_position)
		var aimTo =  %LaserSights.target_position
		var color = Color.KHAKI
		
		if ray.is_colliding():
			var collider = ray.get_collider()
			if collider and collider.is_in_group("Enemy") and cooldown <= 0:
				var contact_point = ray.get_collision_point()
				aimTo = to_local(contact_point)
				color = Color.GREEN
		else:
			aimTo =  %LaserSights.target_position
			
		draw_line(aimFrom,aimTo,color)


func _process(delta):
	cooldown -= delta * TimeManager.gameSpeed / Firerate
	
	if cooldown <= 0 and get_parent().is_in_group("Enemy") and aiming_at() and aiming_at().is_in_group("Player"): 
		cooldown = randf_range(0.98,1.02)
		WeaponManager.shoot(self)
		
	queue_redraw()
