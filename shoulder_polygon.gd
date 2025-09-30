extends Polygon2D

var leftShoulder = Vector2.ZERO
var rightShoulder = Vector2.ZERO
var shoulderMidpoint = Vector2.ZERO
var shoulderFocus = Vector2.ZERO

#get global position of specific point in polygon
func point_position(shape: Node2D,point_number: int):
	var points = shape.polygon
	var local_point = points[point_number]
	var global_point = shape.to_global(local_point)
	return global_point

func update_positions():
	leftShoulder = (point_position(%ShoulderPolygon,0)+point_position(%ShoulderPolygon,4))/2
	$"../LeftShoulder".global_position = leftShoulder
	$"../LeftShoulder".rotation = Movement.cumulativeAngle
	
	rightShoulder = (point_position(%ShoulderPolygon,1)+point_position(%ShoulderPolygon,3))/2
	$"../RightShoulder".global_position = rightShoulder
	$"../RightShoulder".rotation = Movement.cumulativeAngle
	$"../RightElbow".global_position = (point_position(%RightBiceps,2)+point_position(%RightBiceps,4))/2
	
	shoulderMidpoint = (leftShoulder+rightShoulder)/2
	Movement.neck = shoulderMidpoint
	$"../ShoulderMidpoint".global_position = shoulderMidpoint
	
	var directional = rightShoulder - leftShoulder 
	var normal = (Vector2(-directional.y,directional.x).normalized())
	shoulderFocus = shoulderMidpoint + normal * -512
	Movement.shoulderFocus = shoulderFocus
	
	Movement.shoulderOrientation = (Movement.shoulderFocus - Movement.neck).normalized()

func chase_abdomen():
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%ShoulderPolygon,"global_position",$"../AbdomenMidpoint".global_position,Movement.placingWeight*2)#.set_trans(Movement.styleTween)

func rotate_towards_abdomen():
	var diff = Movement.shoulderOrientation.angle_to(Movement.orientation)
	diff = clampf(diff,-45,45)
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%ShoulderPolygon,"rotation",%ShoulderPolygon.rotation+diff,1).set_ease(Tween.EASE_IN_OUT)

func chase_joint(parent:Node2D,joint:Node2D,stiff:float,delta:float):
	var tween: Tween
	tween = create_tween()
	tween.tween_property(joint,"position",parent.global_position,stiff)

func joint_rotation(): #parent:Node2D,joint:Node2D):
	var target = get_global_mouse_position()
	var targetAngle = (target - $"../RightShoulder".global_position).angle() + deg_to_rad(Movement.cumulativeAngle)
	print(rad_to_deg(targetAngle))
	var angleShoulder = clamp(targetAngle,deg_to_rad(Movement.cumulativeAngle)-PI*0.75,deg_to_rad(Movement.cumulativeAngle))
	var angleElbow
	
	var tween: Tween
	tween = create_tween()
	tween.set_parallel()
	tween.tween_property($"../RightShoulderJoint","rotation",angleShoulder,1)
	tween.tween_property($"../RightElbowJoint","rotation",targetAngle,0.5)


func _ready():
	$"../RightShoulderJoint".global_position = Movement.rightShoulder

func _process(delta):
	update_positions()
	chase_abdomen()
	rotate_towards_abdomen()
	chase_joint($"../RightShoulder",$"../RightShoulderJoint",0.1,delta)
	chase_joint($"../RightElbow",$"../RightElbowJoint",0.05,delta)
	
	joint_rotation()
