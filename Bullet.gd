extends Area2D

var travelledDistance = 0

func _physics_process(delta: float) -> void:
	const SPEED = 200
	const RANGE = 1000
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * SPEED * delta * Global.gameSpeed
	travelledDistance += SPEED * delta * Global.gameSpeed
	
	if travelledDistance > RANGE:
		queue_free()



func _on_body_entered(body: Node2D) -> void:
	queue_free()
