extends Control



func _startgame_button_pressed():
	get_tree().change_scene_to_file("res://game.tscn")


func _on_option_button_item_selected(index):
	if index == 0: Global.gameMode = 0
	if index == 1: Global.gameMode = 1
	if index == 2: Global.gameMode = 2

#func _process(delta):
	#print(Global.gameMode)


func _on_bullet_speed_text_changed():
	Global.bulletSpeed = ($BulletSpeed.text)
	pass # Replace with function body.
