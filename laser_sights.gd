extends Node2D

var static_body := StaticBody2D.new()
var collision_shape := CollisionShape2D.new()

func _draw():
	var aimFrom = to_local(%ShootingPoint.global_position)
	var aimTo = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 5000
	
	draw_line(aimFrom,aimTo,Color.KHAKI)


func _ready() -> void:
	add_child(static_body)
	collision_shape.shape = SegmentShape2D.new()
	collision_shape.shape.a = to_local(%ShootingPoint.global_position)
	collision_shape.shape.b = %ShootingPoint.global_position + Vector2.RIGHT.rotated(%ShootingPoint.rotation) * 5000
	static_body.add_child(collision_shape)


func _process(delta):
	queue_redraw()
