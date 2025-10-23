extends CharacterBody2D


var SizeCircle0 = randf_range(2,5)
var SizeCircle1 = randf_range(2,5)
var SizeCircle2 = randf_range(2,5)
var SizeCircle3 = randf_range(2,5)
var SizeCircle4 = randf_range(2,5)
var SizeCircle5 = randf_range(2,5)
var SizeCircle6 = randf_range(2,5)
var SizeCircle7 = randf_range(2,5)


func point_position(shape: Node2D,point_number: int):
	var points = shape.polygon
	var local_point = points[point_number]
	var global_point = shape.to_global(local_point)
	return global_point

func resize_circles():
	SizeCircle0 *= randf_range(0.95,1.05)
	SizeCircle1 *= randf_range(0.95,1.05)
	SizeCircle2 *= randf_range(0.95,1.05)
	SizeCircle3 *= randf_range(0.95,1.05)
	SizeCircle4 *= randf_range(0.95,1.05)
	SizeCircle5 *= randf_range(0.95,1.05)
	SizeCircle6 *= randf_range(0.95,1.05)
	SizeCircle7 *= randf_range(0.95,1.05)

func _draw():
	draw_circle(point_position(%DronePolygon,0),SizeCircle0,Color.AQUA)
	draw_circle(point_position(%DronePolygon,1),SizeCircle1,Color.AQUA)
	draw_circle(point_position(%DronePolygon,2),SizeCircle2,Color.AQUA)
	draw_circle(point_position(%DronePolygon,3),SizeCircle3,Color.AQUA)
	draw_circle(point_position(%DronePolygon,4),SizeCircle4,Color.AQUA)
	draw_circle(point_position(%DronePolygon,5),SizeCircle5,Color.AQUA)
	draw_circle(point_position(%DronePolygon,6),SizeCircle6,Color.AQUA)
	draw_circle(point_position(%DronePolygon,7),SizeCircle7,Color.AQUA)


func _process(delta):
	queue_redraw()
	resize_circles()
