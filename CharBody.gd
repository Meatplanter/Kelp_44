extends Line2D

var midpoint = Vector2(0,16)
var focus = Vector2(0,0)
var bodylength = 32
var cameraState = 0
var cameraCounter = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _draw():
	draw_circle(focus,15.0,Color.RED)
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_point_position(0,%LeftShoe.global_position)
	set_point_position(1,%RightShoe.global_position)
	midpoint = (get_point_position(1)+get_point_position(0))*0.5
	var directional = get_point_position(1)-get_point_position(0)
	var normal = Vector2(-directional.y,directional.x).normalized()
	focus = midpoint + normal * -128
	bodylength = get_point_position(0).distance_to(get_point_position(1))
	cameraCounter = int(midpoint.angle_to_point(focus) * 180 / PI) #przekształcanie radianów na stopnie licząc od osi X
	#print("Counter:",cameraCounter,"  ","State:",cameraState)
	
	if cameraState == 0 && cameraCounter == 0:
		cameraState = 1
		$Marker2D/Camera2D.rotate(0.5 * PI)
	elif cameraState == 0 && cameraCounter == 180:
		cameraState = 3
		$Marker2D/Camera2D.rotate(1.5 * PI)
		
	elif cameraState == 1 && cameraCounter == 90:
		cameraState = 2
		$Marker2D/Camera2D.rotate(0.5 * PI)
	elif cameraState == 1 && cameraCounter == -90:
		cameraState = 0
		$Marker2D/Camera2D.rotate(1.5 * PI)
		
	elif cameraState == 2 && cameraCounter == 180:
		cameraState = 3
		$Marker2D/Camera2D.rotate(0.5 * PI)
	elif cameraState == 2 && cameraCounter == 0:
		cameraState = 1
		$Marker2D/Camera2D.rotate(1.5 * PI)
		
	elif cameraState == 3 && cameraCounter == -90:
		cameraState = 0
		$Marker2D/Camera2D.rotate(0.5 * PI)
	elif cameraState == 3 && cameraCounter == 90:
		cameraState = 2
		$Marker2D/Camera2D.rotate(1.5 * PI)
		
	queue_redraw()
	pass
