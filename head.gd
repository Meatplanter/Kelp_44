extends Area2D

var targetEnemy = null
var enemiesInRange = []

func _physics_process(delta):
	
	enemiesInRange.clear()
	
	for body in get_overlapping_bodies():
		if body.has_meta("Enemy") && body.get_meta("Enemy") == true:
			enemiesInRange.append(body)
		
	if enemiesInRange.size() > 0:
		targetEnemy = enemiesInRange.front()
	else:
		targetEnemy = null
	
	Global.targetEnemy = targetEnemy
