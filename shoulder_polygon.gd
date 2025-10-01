extends Polygon2D

var leftShoulder = Vector2.ZERO
var rightShoulder = Vector2.ZERO
var shoulderMidpoint = Vector2.ZERO
var shoulderFocus = Vector2.ZERO

var target = Vector2.ZERO

#get global position of specific point in polygon
func point_position(shape: Node2D,point_number: int):
	var points = shape.polygon
	var local_point = points[point_number]
	var global_point = shape.to_global(local_point)
	return global_point

#Get a normalized perpendicular vector
func find_orientation(pointA:Vector2, pointB: Vector2):
	var midpoint = (pointA + pointB)/2
	var directional = pointA - pointB
	var normal = (Vector2(-directional.y,directional.x).normalized())
	var focus = midpoint + normal * -512
	var orientation = (focus - midpoint).normalized()
	return orientation

func update_positions():
	leftShoulder = (point_position(%ShoulderPolygon,0)+point_position(%ShoulderPolygon,4))/2
	$"../LeftShoulder".global_position = leftShoulder
	$"../LeftShoulder".rotation = Movement.cumulativeAngle
	$"../LeftElbow".global_position = (point_position(%LeftBiceps,1)+point_position(%LeftBiceps,5))/2
	
	rightShoulder = (point_position(%ShoulderPolygon,1)+point_position(%ShoulderPolygon,3))/2
	$"../RightShoulder".global_position = rightShoulder
	$"../RightShoulder".rotation = Movement.cumulativeAngle
	$"../RightElbow".global_position = (point_position(%RightBiceps,2)+point_position(%RightBiceps,4))/2
	
	shoulderMidpoint = (leftShoulder+rightShoulder)/2
	Movement.neck = shoulderMidpoint
	$"../ShoulderMidpoint".global_position = shoulderMidpoint
	Movement.shoulderOrientation = find_orientation(rightShoulder,leftShoulder)
	
	target = Vector2(40,-50)


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

func joint_rotation(joint: Node2D, target: Vector2, duration: float, min: float, max: float): #parent:Node2D,joint:Node2D):
	var targetAngle = (target - joint.global_position).angle()
	
	targetAngle = lerp_angle(joint.rotation,targetAngle,1.0)
	targetAngle = clamp(targetAngle,deg_to_rad(Movement.cumulativeAngle)-min,deg_to_rad(Movement.cumulativeAngle)+max)
	var tween = create_tween()
	tween.tween_property(joint,"rotation",targetAngle,duration)
	

func _ready():
	$"../RightShoulderJoint".global_position = Movement.rightShoulder

func _process(delta):
	update_positions()
	chase_abdomen()
	rotate_towards_abdomen()
	
	print(rad_to_deg((target - $"../RightShoulderJoint".global_position).angle()))
	
	#left shoulder
	chase_joint($"../LeftShoulder",$"../LeftShoulderJoint",0.1,delta)
	joint_rotation($"../LeftShoulderJoint",target,1.0,-PI,PI*0.75)
	
	#left elbow
	chase_joint($"../LeftElbow",$"../LeftElbowJoint",0.05,delta)
	
	#right shoulder
	chase_joint($"../RightShoulder",$"../RightShoulderJoint",0.1,delta)
	joint_rotation($"../RightShoulderJoint",target,1.0,PI*0.75,0)
	
	#right elbow
	chase_joint($"../RightElbow",$"../RightElbowJoint",0.05,delta)
	joint_rotation($"../RightElbowJoint",target,0.5,-($"../RightShoulderJoint".rotation-deg_to_rad(Movement.cumulativeAngle)-PI*0.4),$"../RightShoulderJoint".rotation-deg_to_rad(Movement.cumulativeAngle))
