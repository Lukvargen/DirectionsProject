extends Label



func _ready():
	Global.player.get_ref().connect("time_changed", self, "time_changed")





func time_changed(current_time):
	text = "Time: " + str(current_time).pad_decimals(2)


