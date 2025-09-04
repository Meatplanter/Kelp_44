extends Area2D

var travelledDistance = 0
var bulletSpeed = Global.bulletSpeed
var bulletRange = Global.bulletRange
var bulletContact = 1 - Global.bulletSlowdown
var bulletSlowdown = Global.bulletSlowdown + bulletContact

var bulletEntryPoint = Vector2.ZERO
var bulletEntryDistance
var shootingPoint
var shootingDistance

var bloodTrailScene = preload("res://blood_trail_pc.tscn")

func _ready() -> void:
	shootingPoint = global_position
	#print(shootingPoint)


func _process(delta: float) -> void:
	#get_parent().get_parent().add_child(bloodTrail)
	if Global.gameSpeed == Global.bulletTime:
			$SplatterTimer.set_paused(1)
			$SlomoSplatterTimer.set_paused(0)
	elif Global.gameSpeed == Global.normalTime:
			$SlomoSplatterTimer.set_paused(1)
			$SplatterTimer.set_paused(0)
	
	shootingDistance = clamp(shootingPoint.distance_to(global_position),0,160) #tracer appears only after shooting
	$Tracer.position.x = - shootingDistance
	$SubViewport/Tracer2.position.x = shootingDistance - 162
	
	if $Bullet.is_visible_in_tree() == false: #tracer disappears as bullet enters body
		bulletEntryDistance = bulletEntryPoint.distance_to(global_position)
		$SubViewport.size.x = 160 - (bulletEntryDistance + (160 - shootingDistance))
		
		
		if bulletEntryDistance >= 160:
			queue_free()
			

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(rotation)
	position += direction * bulletSpeed * delta * Global.gameSpeed * bulletSlowdown
	if bulletContact == 0.0: bulletSlowdown = bulletSlowdown * Global.bulletSlowdown
	travelledDistance += bulletSpeed * delta * Global.gameSpeed
	
	if travelledDistance > bulletRange*bulletSlowdown:
		Global.bulletsDodged += 1
		queue_free()
	#print(bulletRange*bulletSlowdown,"  ",bulletSlowdown, " trav dist ",travelledDistance)
	#print(2/(pow(bulletSlowdown,5)))
	#$SubViewport.size = Vector2(160,3) - Vector2(delta,3)

func _on_body_entered(body: Node2D) -> void:
	$Bullet.hide()
	bulletEntryPoint = global_position
	bulletContact = 0.0
	const WOUND = preload("res://wound.tscn")
	var new_wound = WOUND.instantiate()
	if body.has_method("take_damage"):
		body.take_damage()
		body.add_child(new_wound)
		new_wound.global_position = bulletEntryPoint
		

func _on_splatter_timer_timeout() -> void:
	if $Bullet.is_visible_in_tree() == false && Global.bloodTrialVisible == true:
		var bloodTrail = bloodTrailScene.instantiate()
		bloodTrail.rotation_degrees = randf_range(0,360)
		bloodTrail.scale = Vector2(randf_range(0.5,2),randf_range(0.5,2))
		bloodTrail.global_position = self.global_position
		get_parent().add_child(bloodTrail)

func _on_slomo_splatter_timer_timeout() -> void:
	if $Bullet.is_visible_in_tree() == false && Global.bloodTrialVisible == true:
		var bloodTrail = bloodTrailScene.instantiate()
		bloodTrail.rotation_degrees = randf_range(0,360)
		bloodTrail.scale = Vector2(randf_range(0.5,2),randf_range(0.5,2))
		bloodTrail.global_position = self.global_position
		get_parent().add_child(bloodTrail)
