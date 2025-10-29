extends Label

func _process(_delta):
	text = str(Global.expToLevel-Global.currentExp)
