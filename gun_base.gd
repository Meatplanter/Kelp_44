extends Node2D

@export var Laser_sights := false
@export var Firerate := 1.0
@export var Bullet_speed := 120.0

var cooldown = 100
var canShoot = true

var normalTimer
var slomoTimer

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


func adjust_cooldown_to_time():
	if TimeManager.gameSpeed == TimeManager.normalTime:
		normalTimer.set_paused(0)
		slomoTimer.set_paused(1)
	elif TimeManager.gameSpeed == TimeManager.bulletTime:
		normalTimer.set_paused(1)
		slomoTimer.set_paused(0)


func _ready():
	#add timers for normal / slomo time
	normalTimer = TimeManager.add_normal_timer(Firerate/100)
	normalTimer.timeout.connect(func():
		cooldown -= 1
		)
	slomoTimer = TimeManager.add_slomo_timer(Firerate/100)
	slomoTimer.timeout.connect(func():
		cooldown -= 1
		)


func _process(delta):
	if cooldown <= 0: 
		WeaponManager.shoot(self)
		cooldown = int(randf_range(98,102))
	adjust_cooldown_to_time()
	queue_redraw()
