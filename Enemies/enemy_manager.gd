extends Node

var enemies: Array = []
var visibleEnemies: Array = []

var EnemiesNoticed: Array = []
var EnemyStats: Dictionary = {}  # Stores up-to-date data each frame

var targetEnemyLeft = null
var targetEnemyRight = null

var enemyHealth = 2
var enemyFirerate = 1.0

var maxX = 0
var minX = 0
var maxY = 0
var minY = 0

func register_enemy(enemy):
	enemies.append(enemy)

func unregister_enemy(enemy):
	enemies.erase(enemy)

func get_enemies() -> Array:
	return enemies

func get_visible_enemies() -> Array:
	visibleEnemies.clear()
	get_enemies()
	for enemy in enemies:
		if enemy.modulate.a > 0.5:
			visibleEnemies.append(enemy)
	return visibleEnemies

func enemy_scope():
	maxX = Global.midpoint.x
	minX = Global.midpoint.x
	maxY = Global.midpoint.y
	minY = Global.midpoint.y
	
	get_enemies()
	for enemy in enemies:
		if enemy.modulate.a > 0:
			if enemy.global_position.x > maxX:
				maxX = enemy.global_position.x +32
			if enemy.global_position.x < minX:
				minX = enemy.global_position.x -32
			if enemy.global_position.y > maxY:
				maxY = enemy.global_position.y +32
			if enemy.global_position.y < minY:
				minY = enemy.global_position.y -32
				

#func update_enemy_stats():
	#EnemyStats.clear()
	#
	#for enemy in EnemiesNoticed:
		#if not is_instance_valid(enemy):
			#continue  # Skip freed enemies
			#
		#EnemyStats[enemy] = {
			#"fear": enemy.fear,
			#"attention": enemy.attention,
			#"threat": enemy.threat
	#}

func get_target_priority(enemy) -> int:
	var attention = enemy.attention
	var threat = enemy.threat
	
	if attention < 100 and attention - threat < 0:
		return 1
	elif attention < 100 and attention - threat > 0:
		return 2
	elif attention >= 100 and attention - threat < 0:
		return 3
	else:
		return 4


func sort_enemies_by_importance(enemies: Array) -> Array:
	var sorted_enemies = enemies.duplicate()
	sorted_enemies.sort_custom(func(a, b):
		var pa = get_target_priority(a)
		var pb = get_target_priority(b)
		
		if pa == pb:
			var sa = a.attention + a.threat
			var sb = b.attention + b.threat
			print("int",int(sb - sa))
			return int(sb - sa) # higher total first
		else:
			return int(pa - pb)
	)
	return sorted_enemies

#func _process(delta: float) -> void:
	#EnemiesPriority = sort_enemies_by_importance(EnemiesNoticed)
