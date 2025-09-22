extends Node2D

func _draw():
	if %LeftShoe.weighted == true:
		draw_circle(%LeftShoe.global_position,5.0,Color.RED)
	elif %LeftShoe.weighted == false:
		draw_circle(%LeftShoe.global_position,5.0,Color.GREEN)
	
	if %RightShoe.weighted == true:
		draw_circle(%RightShoe.global_position,5.0,Color.RED)
	elif %RightShoe.weighted  == false:
		draw_circle(%RightShoe.global_position,5.0,Color.GREEN)
		
	#draw_circle(Movement.focus,5.0,Color.AQUA)
	
	draw_line(Movement.CurrPosLeft,Movement.CurrPosRight,Color.AQUA)

func _process(delta):
	#print("Left shoe weighted: ",%LeftShoe.weighted)
	#print("Right shoe weighted: ",%RightShoe.weighted)
	queue_redraw()
