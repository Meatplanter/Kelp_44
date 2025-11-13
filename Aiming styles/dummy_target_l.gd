extends StaticBody2D

var attention = 100.0
var threat = 0.0

func _ready() -> void:
	EnemyManager.EnemiesNoticed.append(self)
	EnemyManager.EnemiesOutOfReach.append(self)
	threat = randf_range(0,50)

func _process(delta: float) -> void:
	global_position = Movement.midpoint + Vector2(-125,-25).rotated(deg_to_rad(Movement.cumulativeAngle))
	threat += TimeManager.gameSpeed
	attention = 100.0
	threat = min(threat,200.0)
	
	$LabelL.text = "Thr: "+str(int(threat))
