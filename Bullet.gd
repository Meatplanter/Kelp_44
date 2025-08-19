extends Area2D

var travelledDistance = 0
var bulletSpeed = Global.bulletSpeed
var bulletRange = Global.bulletRange

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * bulletSpeed * delta * Global.gameSpeed
	travelledDistance += bulletSpeed * delta * Global.gameSpeed
	if travelledDistance > bulletRange:
		Global.bulletsDodged += 1
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	queue_free()
	if body.has_method("take_damage"):
		body.take_damage()
	else: #player body (generated dynamically)
		Global.playerHealth -= 1
