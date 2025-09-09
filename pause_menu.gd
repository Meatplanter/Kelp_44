extends Control



func _on_resume_pressed():
	print("moo")
	get_tree().paused = false
	hide()

func _on_exit_pressed():
	get_tree().quit()
