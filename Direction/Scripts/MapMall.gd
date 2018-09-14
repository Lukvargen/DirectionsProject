extends Node2D



func _ready():
	Global.level_playing = name.to_lower()
	print(Global.level_playing)
