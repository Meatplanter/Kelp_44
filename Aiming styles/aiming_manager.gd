extends Node


var neck := Vector2(16,0) #If no viable target - cross arms by targetting neck
var targetLeft := neck
var targetRight := neck
var cooldownLeft
var cooldownRight

func preferred_target(target):
	var prefTarget
	if EnemyManager.EnemiesMemorized.size() > 0: 
		prefTarget = EnemyManager.EnemiesMemorized.front()
		EnemyManager.EnemiesMemorized.erase(prefTarget)
		EnemyManager.EnemiesEngaged.append(prefTarget)
		prefTarget.enemyState = "Engaged"
	elif EnemyManager.EnemiesEngaged.size() > 0:
		prefTarget = EnemyManager.EnemiesEngaged.front()
	elif EnemyManager.EnemiesShotAt.size() > 0: 
		prefTarget = EnemyManager.EnemiesShotAt.front()
		EnemyManager.EnemiesShotAt.erase(prefTarget)
		EnemyManager.EnemiesEngaged.append(prefTarget)
		prefTarget.enemyState = "Engaged"
	elif EnemyManager.EnemiesNoticed.size() > 0:
		prefTarget = EnemyManager.EnemiesNoticed.front()
		EnemyManager.EnemiesNoticed.erase(prefTarget)
		EnemyManager.EnemiesEngaged.append(prefTarget)
		prefTarget.enemyState = "Engaged"
	else: prefTarget = neck
	return prefTarget.global_position if prefTarget is Node2D else prefTarget

#this is silly. it should be done on the basis of nodes, so that the location updates automatically and the preferred target called only when the previous enemy was shot.
func _process(_delta: float) -> void:
	targetLeft = preferred_target(targetLeft)
	targetRight = preferred_target(targetRight)
