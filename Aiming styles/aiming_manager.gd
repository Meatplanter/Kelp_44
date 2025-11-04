extends Node


var neck := Vector2(16,0) #If no viable target - cross arms by targetting neck
var targetLeft := neck
var targetRight := neck
var cooldownLeft
var cooldownRight


#func _process(_delta: float) -> void:
