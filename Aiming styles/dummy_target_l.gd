extends StaticBody2D

var attention = 100.0
var threat = 0.0

func _ready() -> void:
	EnemyManager.EnemiesNoticed.append(self)
	threat = randf_range(0,50)
	print("l threat ",threat)

func _process(delta: float) -> void:
	global_position = Movement.midpoint + Vector2(-125,0).rotated(deg_to_rad(Movement.cumulativeAngle))
	threat += TimeManager.gameSpeed
	attention = 100.0
	print("l threat ",threat)
