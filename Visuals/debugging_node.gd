extends Node2D

#func _draw():
	#if %LeftShoe.weighted == true:
		#draw_circle(%LeftShoe.global_position,5.0,Color.RED)
	#elif %LeftShoe.weighted == false:
		#draw_circle(%LeftShoe.global_position,5.0,Color.GREEN)
	#
	#if %RightShoe.weighted == true:
		#draw_circle(%RightShoe.global_poition,5.0,Color.RED)
	#elif %RightShoe.weighted  == false:
		#draw_circle(%RightShoe.global_position,5.0,Color.GREEN)
		
	#draw_circle(%ShoulderPolygon.target,5.0,Color.AQUA)
	
	#draw_line(Movement.CurrPosLeft,Movement.CurrPosRight,Color.AQUA)
	
	

#func _process(delta):
	#print($"../RightShoulderJoint".global_position)
	#print("Right shoe weighted: ",%RightShoe.weighted)
	#print($"../RightShoulder".global_position.distance_to($"../RightShoulderJoint".global_position))
	#queue_redraw()
