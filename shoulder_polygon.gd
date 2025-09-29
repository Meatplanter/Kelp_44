extends Polygon2D

var leftShoulder = Vector2.ZERO
var rightShoulder = Vector2.ZERO
var shoulderMidpoint = Vector2.ZERO
var shoulderFocus = Vector2.ZERO

#get global position of specific point in shoulder polygon
func point_position(point_number: int):
	var points = %ShoulderPolygon.polygon
	var local_point = points[point_number]
	var global_point = %ShoulderPolygon.to_global(local_point)
	return global_point

func update_positions():
	leftShoulder = (point_position(0)+point_position(4))/2
	$"../LeftShoulder".global_position = leftShoulder
	
	rightShoulder = (point_position(1)+point_position(3))/2
	$"../RightShoulder".global_position = rightShoulder
	
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
	tween.tween_property(%ShoulderPolygon,"rotation",%ShoulderPolygon.rotation+diff,1)

func _process(delta):
	update_positions()
	chase_abdomen()
	rotate_towards_abdomen()
