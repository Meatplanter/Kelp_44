extends CharacterBody2D


func check_collision(point: Vector2) -> bool:
	var space_state = get_world_2d().direct_space_state
	var params = PhysicsPointQueryParameters2D.new()
	params.position = point   # your Vector2 point
	params.collide_with_areas = true
	params.collide_with_bodies = true
	var result = space_state.intersect_point(params)
	
	if result.size() > 0: return true
	else: return false


func can_move(body: Node2D, dir: Vector2) -> bool:
	var targetPos = body.global_position + dir * Movement.moveDistance
	if check_collision(targetPos) == true: return false
	else: return true
	

func move_left(dir: Vector2):
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%LeftShoe,"position",dir*Movement.moveDistance,Movement.moveTime).set_trans(Movement.styleTween)
	
func move_right(dir: Vector2):
	var tween: Tween
	tween = create_tween()
	tween.tween_property(%RightShoe,"position",dir*Movement.moveDistance,Movement.moveTime).set_trans(Movement.styleTween)

#func _ready():
	#if can_move($RightShoe,Movement.DirRight) == true: print("yay")
	#else: print("oof")
	

func _input(event):
	if event.is_action_pressed("RS_move_right"): 
		move_right(Movement.DirRight)
