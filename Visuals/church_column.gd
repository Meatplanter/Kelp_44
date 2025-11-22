extends StaticBody2D

func make_circle_occluder(radius: float, points := 32):
	var poly := PackedVector2Array()
	for i in range(points):
		var angle = TAU * i / points
		poly.append(Vector2(cos(angle), sin(angle)) * radius)
	$LightOccluder2D.occluder = OccluderPolygon2D.new()
	$LightOccluder2D.occluder.polygon = poly

func _ready():
	make_circle_occluder(122)
