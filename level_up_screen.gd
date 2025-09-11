extends Control

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_1:
			_on_movement_pressed()
		elif event.keycode == KEY_2:
			_on_bullet_speed_pressed()
		elif event.keycode == KEY_3:
			_on_hitbox_pressed()

func _on_movement_pressed():
	get_tree().paused = false
	hide()
	Global.pureMovement *= 0.9
	Global.placingWeight *= 0.9


func _on_bullet_speed_pressed():
	get_tree().paused = false
	hide()
	Global.bulletSpeed *= 0.9


func _on_hitbox_pressed():
	get_tree().paused = false
	hide()
	Global.TorsoCollisionNode.scale *= 0.9
