extends Node


var neck := Vector2(16,0) #If no viable target - cross arms by targetting neck
var targetLeft = null #node
var targetLeftPos #vector
var targetRight = null #node
var targetRightPos #vector
var cooldownLeft
var cooldownRight


func _process(_delta: float) -> void:
	if targetLeft == null: targetLeftPos = neck
	else: targetLeftPos = targetLeft.global_position
	
	if targetRight == null: targetRightPos = neck
	else: targetRightPos = targetRight.global_position
