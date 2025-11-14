extends Node2D

#AimingStlye2: Character aims and shoots automatically.

var gunRight = Node2D
var gunLeft = Node2D

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

func should_shoot(gun: Node2D):
	if gun == gunLeft and AimingManager.targetLeft != null and gun.aiming_at() == AimingManager.targetLeft and AimingManager.cooldownLeft <= 0.0: return true
	elif gun == gunRight and AimingManager.targetRight != null and gun.aiming_at() == AimingManager.targetRight and AimingManager.cooldownRight <= 0.0: return true
	else: return false

func _ready():
	gunRight = get_node("../GunRight")
	gunLeft = get_node("../GunLeft")

func _process(_delta):
	
	if %HeadAS2: %HeadAS2.global_position = AimingManager.neck
	establish_enemies_out_of_reach(EnemyManager.EnemiesNoticed)
	
	if AimingManager.targetLeft == null:
		if pick_target() != null: 
			var target = pick_target()
			AimingManager.targetLeft = target
	
	if AimingManager.targetRight == null:
		if pick_target() != null: 
			var target = pick_target()
			AimingManager.targetRight = target
	
	if should_shoot(gunLeft):
		gunLeft.aiming_at().attention *= 0.5
		gunLeft.aiming_at().threat *= 0.5
		WeaponManager.shoot(gunLeft)
		AimingManager.targetLeft = null
	
	if should_shoot(gunRight):
		gunRight.aiming_at().attention *= 0.5
		gunRight.aiming_at().threat *= 0.5
		WeaponManager.shoot(gunRight)
		AimingManager.targetRight = null
		
	if AimingManager.targetRight in EnemyManager.EnemiesOutOfReach: AimingManager.targetRight = null
	if AimingManager.targetLeft in EnemyManager.EnemiesOutOfReach: AimingManager.targetLeft = null
