extends Node

var enemies: Array = []
var visibleEnemies: Array = []
var targetEnemyLeft = null
var targetEnemyRight = null

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
				
