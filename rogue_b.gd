extends CharacterBody2D

var moveCooldown = false
var hasMoved = false

var vecBefore = Vector2.ZERO
var vecAfter = Vector2.ZERO

#other shoe based on current
func other_shoe(body: Node2D):
	if body == %LeftShoe: return %RightShoe
	elif body == %RightShoe: return %LeftShoe

#check central point of movement for collisions
func check_collision(point: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsPointQueryParameters2D.new()
	params.position = point   # your Vector2 point
	params.collide_with_areas = true
	params.collide_with_bodies = true
	var result = space_state.intersect_point(params)
	
	if result.size() > 0: return true
	else: return false

#check if target movement point has collisions or is beyond max movement distance or on cooldown
func can_move(body: Node2D, dir: Vector2) -> bool:
	
	var other = other_shoe(body)
	
	var targetPos = body.global_position + dir * Movement.moveDistance
	var dist = targetPos.distance_to(other.global_position)
	
	if check_collision(targetPos) == true or dist > Movement.maxMoveDistance or moveCooldown == true: return false
	else: return true

#is current shoe weighted
func is_weighted(body: Node2D):
	
	if body == %LeftShoe and %LeftShoe.weighted == true: return true
	elif body == %LeftShoe and %LeftShoe.weighted == false: return false
	elif body == %RightShoe and %RightShoe.weighted == true: return true
	elif body == %RightShoe and %RightShoe.weighted == false: return false

#change weight distribution
func shift_weight():
	if %LeftShoe.weighted == true:
		%LeftShoe.weighted = false
		%RightShoe.weighted = true
	elif %RightShoe.weighted == true:
		%LeftShoe.weighted = true
		%RightShoe.weighted = false

#establish move type
func move_type(body: Node2D, dir: Vector2):
	
	var other = other_shoe(body)
	
	var targetPos = body.global_position + dir * Movement.moveDistance
	var dist = round(targetPos.distance_to(other.global_position))
	
	var diagonal
	if dir == Movement.DirRight or dir == Movement.DirLeft or dir == Movement.DirUp or dir == Movement.DirDown: diagonal = false
	else: diagonal = true
	
	if is_weighted(body) == false && dist == Movement.moveDistance && diagonal == false: return 1 #Movement.moveSimpleOptimal
	elif is_weighted(body) == false && dist == Movement.moveDistance && diagonal == true: return 3 #Movement.moveComplexOptimal - but turning
	elif is_weighted(body) == true && dist == Movement.moveDistance && diagonal == true: return 4 #Movement.moveComplexHeavy - but turning
	elif is_weighted(body) == true && dist == Movement.moveDistance: return 2 #Movement.moveSimpleHeavy
	elif is_weighted(body) == false && dist > Movement.moveDistance: return 3 #Movement.moveComplexOptimal
	elif is_weighted(body) == true && dist > Movement.moveDistance: return 4 #Movement.moveComplexHeavy
	


#calculate move time
func move_time(body: Node2D, dir: Vector2):
	
	var diagonal = 1
	if dir == Movement.DirRight or dir == Movement.DirLeft or dir == Movement.DirUp or dir == Movement.DirDown: diagonal = 1
	else: diagonal = sqrt(2)
	
	if move_type(body, dir) == 1: return Movement.moveSimpleOptimal * diagonal
	elif move_type(body, dir) == 2: return Movement.moveSimpleHeavy * diagonal
	elif move_type(body, dir) == 3: return Movement.moveComplexOptimal * diagonal
	elif move_type(body, dir) == 4: return Movement.moveComplexHeavy * diagonal


#calculate weight shift
func calculate_shift_weight(body:Node2D,dir:Vector2):
	var moveType = move_type(body,dir)
	var moveTime = move_time(body,dir)
	
	if moveType == 1: return
	elif moveType == 2:
		await get_tree().create_timer(moveTime / 2).timeout
		shift_weight()
	elif moveType == 3:
		await get_tree().create_timer(moveTime / 2).timeout
		shift_weight()
	elif moveType == 4:
		shift_weight()
		await get_tree().create_timer(moveTime / 2).timeout
		shift_weight()
	#elif moveType == 5:


#movement
func move(body:Node2D, dir: Vector2):
	if can_move(body,dir) == true:
		
		var moveType = move_type(body,dir)
		var moveTime = move_time(body,dir)
		
		#establish weight distribution, esp. first step 
		if hasMoved == false and is_weighted(body) == true:
			hasMoved = true
			var other = other_shoe(body)
			other.weighted = false
		else: calculate_shift_weight(body,dir)
		
		#print(moveTime)
		
		moveCooldown = true
		$MovementCooldown.wait_time = moveTime
		$MovementCooldown.start()
		
		var dist = Movement.moveDistance
		
		var tween: Tween
		tween = create_tween()
		tween.tween_property(body,"position",body.global_position + dir * dist,moveTime).set_trans(Movement.styleTween)

#update baseline positions
func update_positions():
	Movement.CurrPosLeft = %LeftShoe.global_position
	Movement.CurrPosRight = %RightShoe.global_position
	Movement.midpoint = (%RightShoe.global_position + %LeftShoe.global_position)/2
	
	var directional = %RightShoe.global_position - %LeftShoe.global_position 
	var normal = (Vector2(-directional.y,directional.x).normalized())
	Movement.focus = Movement.midpoint + normal * -512
	
	Movement.orientation = (Movement.focus - Movement.midpoint).normalized()

#Move hips in line with shoes
func shift_abdomen():
	%AbdomenPolygon.global_position = Movement.midpoint
	%AbdomenPolygon.look_at(Movement.focus)
	%AbdomenPolygon.rotate(-PI/2)
	
	if is_weighted(%LeftShoe) and is_weighted(%RightShoe):
		var tween: Tween
		tween = create_tween()
		tween.set_parallel()
		tween.tween_property(%AbdomenPolygon,"position",Movement.midpoint,Movement.placingWeight)#.set_trans(Movement.styleTween)
		tween.tween_property($AbdomenMidpoint,"position",Movement.midpoint,Movement.placingWeight)#.set_trans(Movement.styleTween)
	elif is_weighted(%LeftShoe): 
		var tween: Tween
		tween = create_tween()
		tween.set_parallel()
		tween.tween_property(%AbdomenPolygon,"position",Movement.midpoint.lerp(Movement.CurrPosLeft,0.7),Movement.placingWeight*2)#.set_trans(Movement.styleTween)
		tween.tween_property($AbdomenMidpoint,"position",Movement.midpoint.lerp(Movement.CurrPosLeft,0.7),Movement.placingWeight*2)
	elif is_weighted(%RightShoe): 
		var tween: Tween
		tween = create_tween()
		tween.set_parallel()
		tween.tween_property(%AbdomenPolygon,"position",Movement.midpoint.lerp(Movement.CurrPosRight,0.7),Movement.placingWeight*2)#.set_trans(Movement.styleTween)
		tween.tween_property($AbdomenMidpoint,"position",Movement.midpoint.lerp(Movement.CurrPosRight,0.7),Movement.placingWeight*2)


func _ready():
	vecBefore = Movement.orientation
	vecAfter = Movement.orientation


func _process(delta):
	vecBefore = Movement.orientation
	update_positions()
	shift_abdomen()
	vecAfter = Movement.orientation
	var diff = rad_to_deg(vecBefore.angle_to(vecAfter))
	Movement.cumulativeAngle += diff
	#print(round(Movement.cumulativeAngle))


func _input(event):
	if event.is_action_pressed("RS_move_right"): move(%RightShoe,Movement.DirRight)
	elif event.is_action_pressed("RS_move_left"): move(%RightShoe,Movement.DirLeft)
	elif event.is_action_pressed("RS_move_up"): move(%RightShoe,Movement.DirUp)
	elif event.is_action_pressed("RS_move_down"): move(%RightShoe,Movement.DirDown)
	elif event.is_action_pressed("RS_move_rightup"): move(%RightShoe,Movement.DirRightUp)
	elif event.is_action_pressed("RS_move_rightdown"): move(%RightShoe,Movement.DirRightDown)
	elif event.is_action_pressed("RS_move_leftup"): move(%RightShoe,Movement.DirLeftUp)
	elif event.is_action_pressed("RS_move_leftdown"): move(%RightShoe,Movement.DirLeftDown)
	
	elif event.is_action_pressed("LS_move_right"): move(%LeftShoe,Movement.DirRight)
	elif event.is_action_pressed("LS_move_left"): move(%LeftShoe,Movement.DirLeft)
	elif event.is_action_pressed("LS_move_up"): move(%LeftShoe,Movement.DirUp)
	elif event.is_action_pressed("LS_move_down"): move(%LeftShoe,Movement.DirDown)
	elif event.is_action_pressed("LS_move_rightup"): move(%LeftShoe,Movement.DirRightUp)
	elif event.is_action_pressed("LS_move_rightdown"): move(%LeftShoe,Movement.DirRightDown)
	elif event.is_action_pressed("LS_move_leftup"): move(%LeftShoe,Movement.DirLeftUp)
	elif event.is_action_pressed("LS_move_leftdown"): move(%LeftShoe,Movement.DirLeftDown)


func _on_movement_cooldown_timeout():
	moveCooldown = false
	$MovementCooldown.stop()
