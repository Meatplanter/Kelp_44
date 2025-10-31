extends Node2D

#AimingStlye2: Character aims and shoots automatically.


func _process(_delta):
	if %HeadAS2: %HeadAS2.global_position = AimingManager.neck
