extends Polygon2D

var leftShoulder = Vector2.ZERO
var rightShoulder = Vector2.ZERO
var shoulderMidpoint = Vector2.ZERO
var shoulderFocus = Vector2.ZERO

var target = Vector2.ZERO

#joint rotation speed
var shoulderSpeed = 1.0
var leftShoulderSpeedModifier = 1.0
var rightShoulderSpeedModifier = 1.0
var elbowSpeed = 0.5
var leftElbowSpeedModifier = 1
var rightElbowSpeedModifier = 1


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


func find_angle_between(pointA:Node2D, middle: Node2D, pointB: Node2D):
	var lineA = (pointA.global_position - middle.global_position).normalized()
	var lineB = (pointB.global_position - middle.global_position).normalized()
	var angle = rad_to_deg(lineA.angle_to(lineB))
	return angle


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
	
	%GunLeft.global_position = (point_position(%LeftForearm,1)+point_position(%LeftForearm,5))/2
	%GunLeft.global_rotation = $"../LeftElbowJoint".global_rotation + PI
	%GunRight.global_position = (point_position(%RightForearm,2)+point_position(%RightForearm,4))/2
	%GunRight.global_rotation = $"../RightElbowJoint".global_rotation
	
	target = get_global_mouse_position()
	$"../TargetNode".global_position = target
	#target = Vector2(100,-100)


func chase_abdomen():
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%ShoulderPolygon,"global_position",$"../AbdomenMidpoint".global_position,Movement.placingWeight*2 / TimeManager.gameSpeed)#.set_trans(Movement.styleTween)


func rotate_towards_abdomen():
	var diff = Movement.shoulderOrientation.angle_to(Movement.orientation)
	diff = clampf(diff,-45,45)
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%ShoulderPolygon,"rotation",%ShoulderPolygon.rotation+diff,1 / TimeManager.gameSpeed).set_ease(Tween.EASE_IN_OUT)


func chase_joint(parent:Node2D,joint:Node2D,stiff:float):
	var tween: Tween
	tween = create_tween()
	tween.tween_property(joint,"position",parent.global_position,stiff / TimeManager.gameSpeed)


func right_joint_rotation(joint: Node2D, target: Vector2, duration: float, min: float, max: float):
	var targetAngle = (target - joint.global_position).angle()
	
	targetAngle = lerp_angle(joint.rotation,targetAngle,1.0)
	targetAngle = clamp(targetAngle,deg_to_rad(Movement.cumulativeAngle)-min,deg_to_rad(Movement.cumulativeAngle)+max)
	
	var tween: Tween
	tween = create_tween()
	tween.tween_property(joint,"rotation",targetAngle,duration / TimeManager.gameSpeed).set_ease(Tween.EASE_OUT_IN)


func left_joint_rotation(joint: Node2D, target: Vector2, duration: float, min: float, max: float):
	var targetAngle = (target - joint.global_position).angle()+PI
	
	targetAngle = lerp_angle(joint.rotation,targetAngle,1.0)
	targetAngle = clamp(targetAngle,deg_to_rad(Movement.cumulativeAngle)-min,deg_to_rad(Movement.cumulativeAngle)+max)
	
	var tween: Tween
	tween = create_tween()
	tween.tween_property(joint,"rotation",targetAngle,duration / TimeManager.gameSpeed).set_ease(Tween.EASE_OUT_IN)


func lower_right_elbow(elbow: Node2D, bicep: Node2D, target: Vector2):
	var dist = elbow.global_position.distance_to(target)
	bicep.scale.x = clampf(min(dist/75,1),0.3,1)
	bicep.scale.y = clampf(1.5-dist/75,1,1.5)


func lower_left_elbow(elbow: Node2D, bicep: Node2D, target: Vector2):
	var dist = elbow.global_position.distance_to(target)
	bicep.position.x =  - 27 * clampf(min(dist/75,1),0.3,1)
	bicep.scale.x = clampf(min(dist/75,1),0.3,1)
	bicep.scale.y = clampf(1.5-dist/75,1,1.5)


func _ready():
	$"../RightShoulderJoint".global_position = Movement.rightShoulder


func _process(delta):
	
	#For calculating the rotational direction
	var RAangleBefore = find_angle_between($"../LeftShoulder",$"../RightShoulder",%GunRight) #from body to gun cumulative
	var RBangleBefore = find_angle_between($"../LeftShoulder",$"../RightShoulder",$"../RightElbow") #shoulder bending
	var REangleBefore = find_angle_between($"../RightShoulder",$"../RightElbow",%GunRight) #elbow bending
	var LAangleBefore = find_angle_between($"../RightShoulder",$"../LeftShoulder",%GunLeft) #from body to gun cumulative
	var LBangleBefore = find_angle_between($"../RightShoulder",$"../LeftShoulder",$"../LeftElbow") #shoulder bending
	var LEangleBefore = find_angle_between($"../LeftShoulder",$"../LeftElbow",%GunLeft) #elbow bending
	
	
	update_positions()
	chase_abdomen()
	rotate_towards_abdomen()
	
	#left shoulder
	chase_joint($"../LeftShoulder",$"../LeftShoulderJoint",0.1)
	left_joint_rotation($"../LeftShoulderJoint",target,shoulderSpeed * leftShoulderSpeedModifier,0,PI*0.75)
	
	#left elbow
	chase_joint($"../LeftElbow",$"../LeftElbowJoint",0.04)
	left_joint_rotation($"../LeftElbowJoint",target,elbowSpeed * leftElbowSpeedModifier,-($"../LeftShoulderJoint".rotation-deg_to_rad(Movement.cumulativeAngle)),($"../LeftShoulderJoint".rotation-deg_to_rad(Movement.cumulativeAngle)+PI*0.4))
	#lower_left_elbow($"../LeftElbow",%LeftBiceps,target)
	
	#right shoulder
	chase_joint($"../RightShoulder",$"../RightShoulderJoint",0.1)
	right_joint_rotation($"../RightShoulderJoint",target,shoulderSpeed * rightShoulderSpeedModifier,PI*0.75,0)
	
	#right elbow
	chase_joint($"../RightElbow",$"../RightElbowJoint",0.04)
	right_joint_rotation($"../RightElbowJoint",target,elbowSpeed * rightElbowSpeedModifier,-($"../RightShoulderJoint".rotation-deg_to_rad(Movement.cumulativeAngle)-PI*0.4),$"../RightShoulderJoint".rotation-deg_to_rad(Movement.cumulativeAngle))
	#lower_right_elbow($"../RightElbow",%RightBiceps,target)
	
	
	#For calculating the rotational direction (minus values means turning left, plus values means turning right)
	var RAangleAfter = find_angle_between($"../LeftShoulder",$"../RightShoulder",%GunRight)
	var RBangleAfter = find_angle_between($"../LeftShoulder",$"../RightShoulder",$"../RightElbow")
	var REangleAfter = find_angle_between($"../RightShoulder",$"../RightElbow",%GunRight)
	var LAangleAfter = find_angle_between($"../RightShoulder",$"../LeftShoulder",%GunLeft)
	var LBangleAfter = find_angle_between($"../RightShoulder",$"../LeftShoulder",$"../LeftElbow")
	var LEangleAfter = find_angle_between($"../LeftShoulder",$"../LeftElbow",%GunLeft)
	
	var RAdiff = RAangleAfter - RAangleBefore
	var RBdiff = RBangleAfter - RBangleBefore
	var REdiff = REangleAfter - REangleBefore
	var LAdiff = LAangleAfter - LAangleBefore
	var LBdiff = LBangleAfter - LBangleBefore
	var LEdiff = LEangleAfter - LEangleBefore
	
	#increase the speed of shoulder rotation outward, if elbow is already extended
	if RAdiff > 0 and REdiff < 1: rightShoulderSpeedModifier = 0.5
	else: rightShoulderSpeedModifier = 1.0
	if LAdiff < 0 and LEdiff < 1: leftShoulderSpeedModifier = 0.5
	else: leftShoulderSpeedModifier = 1.0
	
	#increase the speed of elbow rotation outward, if shoulder is already rotatated outwards
	if RAdiff > 0 and RBdiff < 1: rightElbowSpeedModifier = 0.5
	else: rightElbowSpeedModifier = 1.0
	if LAdiff < 0 and LBdiff < 1: leftElbowSpeedModifier = 0.5
	else: leftElbowSpeedModifier = 1.0
