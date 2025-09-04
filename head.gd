extends Area2D

var targetEnemyLeft = null
var targetEnemyRight = null
var enemiesInRange = []
var tween: Tween

func _physics_process(delta):
	
	enemiesInRange.clear()
	
	for body in get_overlapping_bodies():
		if body.has_meta("Enemy") && body.get_meta("Enemy") == true:
			enemiesInRange.append(body)
			
	if enemiesInRange.size() > 0:
		targetEnemyLeft = enemiesInRange.front()
		targetEnemyRight = enemiesInRange.front()
		#tween = create_tween()
		#tween.tween_property(self,"rotation",)
		#look_at(targetEnemy.global_position)
	else:
		targetEnemyLeft = null
		targetEnemyRight = null
	
	Global.targetEnemyLeft = targetEnemyLeft
	Global.targetEnemyRight = targetEnemyRight
