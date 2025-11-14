extends Marker2D

#func randomize_location(point: Vector2,max_radius: float):
	#var angle = randf_range(0,TAU)
	#var radius = randf_range(0,max_radius)
	#var new_pos = point + Vector2(cos(angle),sin(angle)) * radius
	#return new_pos
#
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta: float) -> void:
	#global_position = get_global_mouse_position()
	#if $"../Enemy": $"../Enemy".global_position = global_position
	#$"../Crosshair".global_position = randomize_location($"../Enemy".global_position, 10.0)
