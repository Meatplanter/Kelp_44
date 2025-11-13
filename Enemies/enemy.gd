extends CharacterBody2D

var health = EnemyManager.enemyHealth
var firerate = EnemyManager.enemyFirerate

var strafeBool = true

var noticed = false
#var lastNoticed = 25.0
#var lastMemorized = 50.0
var threat = 0.0
var attention = 0.0
#var fear = 0.0 #threat - attention, for involountary glances
#var beingLookedAt = false

func update_noticed_array():
	if attention > 0.0 and not noticed:
		EnemyManager.EnemiesNoticed.append(self)
		noticed = true
	elif attention <= 0.0 and noticed:
		EnemyManager.EnemiesNoticed.erase(self)
		noticed = false


func attention_drop():
	#lastNoticed -= TimeManager.gameSpeed
	#lastNoticed = clampf(lastNoticed,0.0,25.0)
	#lastMemorized -= TimeManager.gameSpeed
	#lastMemorized = clampf(lastMemorized,0.0,50.0)
	
	##attention doesn't drop if you were just memorized or if you were just noticed
	#if attention == 100.0 and lastMemorized > 0.0:
		#pass
	#elif attention >= 25.0:  
		#attention -= TimeManager.gameSpeed
	#elif attention < 25.0 and lastNoticed <= 0.0:
		#attention -= TimeManager.gameSpeed
	#elif attention < 25.0 and lastNoticed > 0.0:
		#pass
		
	if attention > 25: attention -= TimeManager.gameSpeed
	else: attention -= TimeManager.gameSpeed / 2
	
	#if attention > 100: attention *= 0.999
	
	attention = clampf(attention, 0.0, 150.0)

func threat_drop():
	if threat > 100.0:
		threat -= TimeManager.gameSpeed * 2 
	else:
		threat -= TimeManager.gameSpeed
	if attention >= 100: threat -= TimeManager.gameSpeed * 3
	threat = max(0.0,threat)


func chase_player():
	var direction = global_position.direction_to(Movement.midpoint)
	velocity = direction * TimeManager.gameSpeed * 30.0

func strafe(clockwise: bool):
	var direction
	if clockwise == true:
		direction = global_position.direction_to(Movement.midpoint).rotated(PI/2)
	elif clockwise == false:
		direction = global_position.direction_to(Movement.midpoint).rotated(-PI/2)
	velocity = direction * TimeManager.gameSpeed * 30.0

func _ready() -> void:
	EnemyManager.register_enemy(self)
	strafeBool = randf() < 0.5
	firerate = randf_range(firerate*0.75,firerate*1.5)
	%GunNew.Firerate = firerate


func _process(_delta: float) -> void:
	look_at(Movement.midpoint)
	if global_position.distance_to(Movement.midpoint) > 300: 
		chase_player()
	else:
		strafe(strafeBool)
	
	attention_drop()
	threat_drop()
	update_noticed_array()
	
	move_and_slide()
	
	#debugging stuff
	$Label.text = "Att: "+str(int(attention))+"  Thr: "+str(int(threat))
	if self in EnemyManager.EnemiesOutOfReach: $Label.add_theme_color_override("font_color", Color.RED)
	else: $Label.add_theme_color_override("font_color", Color.WHITE)

func take_damage():
	health -= 1
	if health == 0:
		Global.enemiesKilled += 1
		queue_free()
		if Global.gameMode == 1:
			Global.currentExp += Global.xp4enemy

func _exit_tree():
	EnemyManager.unregister_enemy(self)
	EnemyManager.EnemiesNoticed.erase(self)
