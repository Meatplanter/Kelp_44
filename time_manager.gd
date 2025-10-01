extends Node

var normalTime = 1.0
var bulletTime = 0.05
var timeReverse = -0.3
var targettingMode = false
var timeReverseMode = false
var pausePoint = 0

var gameSpeed = 1.0

func add_normal_timer(time: float):
	var normalTimer := Timer.new()
	normalTimer.wait_time = time / TimeManager.normalTime
	normalTimer.autostart = true
	add_child(normalTimer)
	return normalTimer
	
func add_slomo_timer(time: float):
	var slomoTimer := Timer.new()
	slomoTimer.wait_time = time / TimeManager.bulletTime
	slomoTimer.autostart = true
	add_child(slomoTimer)
	return slomoTimer
