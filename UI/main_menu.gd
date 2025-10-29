extends Control

func _input(event):
	if event.is_action_pressed("Space"):
		_startgame_button_pressed()
	
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_Q:
			_on_option_button_item_selected(0)
			$GameMode.selected = 0
		elif event.keycode == KEY_W:
			_on_option_button_item_selected(1)
			$GameMode.selected = 1
		elif event.keycode == KEY_E:
			_on_option_button_item_selected(2)
			$GameMode.selected = 2
		elif event.keycode == KEY_A:
			_on_character_item_selected(0)
			$Character.selected = 0
		elif event.keycode == KEY_S:
			_on_character_item_selected(1)
			$Character.selected = 1
		elif event.keycode == KEY_D:
			_on_character_item_selected(2)
			$Character.selected = 2

func _startgame_button_pressed():
	get_tree().change_scene_to_file("res://Main/game.tscn")


func _on_option_button_item_selected(index):
	if index == 0: Global.gameMode = 0
	if index == 1: Global.gameMode = 1
	if index == 2: Global.gameMode = 2


func _on_bullet_speed_text_changed():
	Global.bulletSpeed = float($BulletSpeed.text)


func _on_normal_time_text_changed():
	Global.normalTime = float($NormalTime.text)


func _on_aiming_speed_text_changed():
	Global.aimingSpeed = float($AimingSpeed.text)


func _on_enemy_health_text_changed():
	Global.enemyHealth = float($EnemyHealth.text)


func _on_player_health_text_changed():
	Global.playerHealth = int($PlayerHealth.text)


func _on_bullet_time_text_changed():
	Global.bulletTime = float($BulletTime.text)


func _on_reverse_time_text_changed():
	Global.timeReverse = float($ReverseTime.text)


func _on_move_distance_text_changed():
	Global.moveDistance = float($MoveDistance.text)


func _on_max_mov_dist_text_changed():
	Global.maxMoveDistance = float($MaxMovDist.text)


func _on_pure_movement_text_changed():
	Global.pureMovement = float($PureMovement.text)


func _on_placing_weight_text_changed():
	Global.placingWeight = float($PlacingWeight.text)


func _on_blood_trail_toggled(toggled_on):
	if toggled_on == true: Global.bloodTrailVisible = true
	elif toggled_on == false: Global.bloodTrailVisible = false


func _on_blood_trail_px_toggled(toggled_on):
	if toggled_on == true: Global.bloodTrailScene = true
	elif toggled_on == false: Global.bloodTrailScene = false


func _on_character_item_selected(index):
	if index == 0: Global.character = "Drone_A"
	if index == 1: Global.character = "Drone_B"
	if index == 2: Global.character = "Rogue_B"
