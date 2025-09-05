extends Node

var enemies: Array = []
var targetEnemyLeft = null
var targetEnemyRight = null

func register_enemy(enemy):
	enemies.append(enemy)

func unregister_enemy(enemy):
	enemies.erase(enemy)

func get_enemies() -> Array:
	return enemies
