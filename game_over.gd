extends CanvasLayer

func _input(event):
	if event is InputEventKey and event.pressed and not event.echo && Global.playerHealth <= 0:
		if event.keycode == KEY_ESCAPE:
			get_tree().quit()
		elif event.keycode == KEY_SPACE:
			#var output = []
			#var args = OS.get_cmdline_args()
			#get_tree().quit()
			#OS.execute(OS.get_executable_path(), args, output,false)
			#
			var args = OS.get_cmdline_args()
			OS.create_process(OS.get_executable_path(), args)
			get_tree().quit()
