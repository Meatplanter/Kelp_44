extends CharacterBody2D

var moveCooldown = false

func other_shoe(body: Node2D):
	if body == %LeftShoe: return %RightShoe
	elif body == %RightShoe: return %LeftShoe

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
	

func is_weighted(body: Node2D):
	
	if body == %LeftShoe and Movement.leftWeighted == true: return true
	elif body == %LeftShoe and Movement.leftWeighted == false: return false
	elif body == %RightShoe and Movement.rightWeighted == true: return true
	elif body == %RightShoe and Movement.rightWeighted == false: return false

#func shift_weight():
	##if Movement.leftWeighted == true and Movement.rightWeighted == true:
	#if Movement.leftWeighted == true:
		#Movement.leftWeighted = false
		#Movement.rightWeighted = true
	#elif Movement.rightWeighted == true:
		#Movement.leftWeighted = true
		#Movement.rightWeighted = false
	

func move_type(body: Node2D, dir: Vector2):
	
	var other = other_shoe(body)
	
	var targetPos = body.global_position + dir * Movement.moveDistance
	var dist = targetPos.distance_to(other.global_position)
	
	if is_weighted(body) == false && dist == Movement.moveDistance: return 1 #Movement.moveSimpleOptimal
	elif is_weighted(body) == true && dist == Movement.moveDistance: return 2 #Movement.moveSimpleHeavy
	elif is_weighted(body) == false && dist > Movement.moveDistance: return 3 #Movement.moveComplexOptimal
	elif is_weighted(body) == true && dist > Movement.moveDistance: return 4 #Movement.moveComplexHeavy

func move_time(body: Node2D, dir: Vector2):
	
	var diagonal
	if dir == Movement.DirRight or dir == Movement.DirLeft or dir == Movement.DirUp or dir == Movement.DirDown: diagonal = 1
	else: diagonal = sqrt(2)
	
	if move_type(body, dir) == 1: return Movement.moveSimpleOptimal * diagonal
	elif move_type(body, dir) == 2: return Movement.moveSimpleHeavy * diagonal
	elif move_type(body, dir) == 3: return Movement.moveComplexOptimal * diagonal
	elif move_type(body, dir) == 4: return Movement.moveComplexHeavy * diagonal

func shift_weight(body:Node2D,dir:Vector2):
	var moveType = move_type(body,dir)
	var moveTime = move_time(body,dir)
	#Ok, pomysł: poruszanie się ma od 0 do 2 przenosin ciężaru. 
	#Dzielimy czas ruchu na takie segmenty i wtedy w zależności od momentu zmieniamy ciężar 

func move(body:Node2D, dir: Vector2):
	if can_move(body,dir) == true:
		var moveType = move_type(body,dir)
		var moveTime = move_time(body,dir)
		
		moveCooldown = true
		$MovementCooldown.wait_time = moveTime
		$MovementCooldown.start()
		
		var dist = Movement.moveDistance
		
		var tween: Tween
		tween = create_tween()
		tween.tween_property(body,"position",body.global_position + dir * dist,moveTime).set_trans(Movement.styleTween)



#func _ready():
	#if can_move($RightShoe,Movement.DirRight) == true: print("yay")
	#else: print("oof")
	

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
