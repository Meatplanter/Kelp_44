extends Camera2D

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("Esc") and get_tree().paused == false:
		get_tree().paused = true
		$"Pause menu".show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
