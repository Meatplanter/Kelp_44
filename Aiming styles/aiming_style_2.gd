extends Node2D

#AimingStlye2: Character aims and shoots automatically.


func establish_enemies_out_of_reach(enemies: Array):
	for enemy in enemies:
		if enemy.is_in_group("Enemy"):
			var enemyOrientation = (enemy.global_position - %HeadAS2.global_position).normalized()
			var angleTo = rad_to_deg(-Movement.orientation.angle_to(enemyOrientation))
			if Movement.cumulativeAngle + angleTo < Movement.cumulativeAngle - 90 or Movement.cumulativeAngle + angleTo > Movement.cumulativeAngle + 90:
				if enemy not in EnemyManager.EnemiesOutOfReach: EnemyManager.EnemiesOutOfReach.append(enemy)
			else:
				if enemy in EnemyManager.EnemiesOutOfReach: EnemyManager.EnemiesOutOfReach.erase(enemy)

func pick_target():
	var availableTargets = []
	var target = Node2D
	
	for n in EnemyManager.EnemiesNoticed:
		if n not in EnemyManager.EnemiesOutOfReach:
			availableTargets.append(n)
		
	if availableTargets.size() > 0: 
		target = availableTargets[0]
		return target
	else:
		return null

func _process(_delta):
	if %HeadAS2: %HeadAS2.global_position = AimingManager.neck
	establish_enemies_out_of_reach(EnemyManager.EnemiesNoticed)
	if pick_target() != null: pick_target()
