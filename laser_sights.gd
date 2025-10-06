extends Node2D

func _draw():
	var aimFrom = to_local(%ShootingPoint.global_position)
	var aimTo = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 50000
	
	draw_line(aimFrom,aimTo,Color.KHAKI)

func _process(delta):
	queue_redraw()
