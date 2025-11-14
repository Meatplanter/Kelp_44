extends Sprite2D

func _process(delta):
	self.modulate.a -= 0.05
	self.modulate.a = max(0.0,self.modulate.a)
