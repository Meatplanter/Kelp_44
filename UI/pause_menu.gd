extends Control


func _on_resume_pressed():
	if get_tree().paused == true:
		Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED_HIDDEN)
		get_tree().paused = false
		hide()

func _on_exit_pressed():
	get_tree().quit()
