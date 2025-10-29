extends Node2D

#AimingStlye2: Character aims automatically.
#Shooting is automatic and reckless, character fires one shot per enemy in passing.

func _process(delta):
	if %HeadAS2: %HeadAS2.global_position = AimingManager.neck
