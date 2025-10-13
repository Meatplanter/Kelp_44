extends Node2D

@export var Laser_sights := false
@export var Firerate := 1.0
@export var Bullet_speed := 120.0

var cooldown = Firerate
var canShoot = true


func _draw():
	if Laser_sights == true:
		var ray = %LaserSights
		
		var aimFrom = to_local(ray.global_position)
		var aimTo
		var color = Color.KHAKI
		
		if ray.is_colliding() and ray.get_collider().has_meta("Enemy"):
			var contact_point = ray.get_collision_point()
			aimTo = to_local(contact_point)
			color = Color.GREEN
		else:
			aimTo =  %LaserSights.target_position
			
		draw_line(aimFrom,aimTo,color)


func _process(delta):
	cooldown -= delta * TimeManager.gameSpeed / Firerate
	if cooldown <= 0: 
		cooldown = randf_range(0.98,1.02)
		WeaponManager.shoot(self)
	queue_redraw()
