extends Line2D

var midpoint = Vector2(0,16)
var focus = Vector2(0,0)
var bodylength = 32
var cameraState = 0
var cameraCounter = 0
var static_body := StaticBody2D.new()
var collision_shape := CollisionShape2D.new()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Adding initial collision shape
	add_child(static_body)
	collision_shape.shape = SegmentShape2D.new()
	collision_shape.shape.a = %LeftShoe.global_position
	collision_shape.shape.b = %RightShoe.global_position
	static_body.add_child(collision_shape)
	#Adding global reference to dig into variables from anywhere
	Global.CharBodyNode = self
	

func _draw():
	draw_circle(focus,15.0,Color.RED)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	set_point_position(0,%LeftShoe.global_position)
	set_point_position(1,%RightShoe.global_position)
	midpoint = (get_point_position(1)+get_point_position(0))*0.5
	Global.midpoint = midpoint
	var directional = get_point_position(1)-get_point_position(0)
	var normal = Vector2(-directional.y,directional.x).normalized()
	focus = midpoint + normal * -128
	bodylength = get_point_position(0).distance_to(get_point_position(1))
	cameraCounter = int(midpoint.angle_to_point(focus) * 180 / PI) #przekształcanie radianów na stopnie licząc od osi X

	collision_shape.shape.a = %LeftShoe.global_position
	collision_shape.shape.b = %RightShoe.global_position
	
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
		
	if Global.playerHealth == 0: #game over screen
		$Marker2D/GameOver.visible = true
		get_tree().paused = true
	
	queue_redraw()
