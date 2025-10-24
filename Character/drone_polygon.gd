extends Polygon2D

@export var minCircleSize = 2
@export var maxCircleSize = 8
@export var minCircleDecr = 0.95
@export var maxCircleIncr = 1.05

var SizeCircle0 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle1 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle2 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle3 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle4 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle5 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle6 = randf_range(minCircleSize,maxCircleSize)
var SizeCircle7 = randf_range(minCircleSize,maxCircleSize)


func point_position(shape: Node2D, point_number: int):
	var points = shape.polygon
	return points[point_number]

func resize_circles():
	SizeCircle0 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle1 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle2 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle3 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle4 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle5 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle6 *= randf_range(minCircleDecr,maxCircleIncr)
	SizeCircle7 *= randf_range(minCircleDecr,maxCircleIncr)
	
	SizeCircle0 = clamp(SizeCircle0,minCircleSize,maxCircleSize)
	SizeCircle1 = clamp(SizeCircle1,minCircleSize,maxCircleSize) 
	SizeCircle2 = clamp(SizeCircle2,minCircleSize,maxCircleSize)
	SizeCircle3 = clamp(SizeCircle3,minCircleSize,maxCircleSize)
	SizeCircle4 = clamp(SizeCircle4,minCircleSize,maxCircleSize)
	SizeCircle5 = clamp(SizeCircle5,minCircleSize,maxCircleSize)
	SizeCircle6 = clamp(SizeCircle6,minCircleSize,maxCircleSize)
	SizeCircle7 = clamp(SizeCircle7,minCircleSize,maxCircleSize)

func randomize_location(point: Vector2,max_radius: float):
	var angle = randf_range(0,TAU)
	var radius = randf_range(0,max_radius)
	var new_pos = point + Vector2(cos(angle),sin(angle)) * radius
	return new_pos

func _draw():
	draw_circle(randomize_location(point_position(%DronePolygon,0),1),SizeCircle0,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,1),1),SizeCircle1,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,2),1),SizeCircle2,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,3),1),SizeCircle3,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,4),1),SizeCircle4,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,5),1),SizeCircle5,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,6),1),SizeCircle6,Color.BLACK)
	draw_circle(randomize_location(point_position(%DronePolygon,7),1),SizeCircle7,Color.BLACK)


func _ready():
	z_index = 100


func _process(delta):
	resize_circles()
	%DronePolygon.rotate(0.02)
	queue_redraw()


func _input(event):
	if event.is_action_pressed("Space"): 
		SizeCircle0 = minCircleSize
		SizeCircle1 = minCircleSize
		SizeCircle2 = minCircleSize
		SizeCircle3 = minCircleSize
		SizeCircle4 = minCircleSize
		SizeCircle5 = minCircleSize
		SizeCircle6 = minCircleSize
		SizeCircle7 = minCircleSize
