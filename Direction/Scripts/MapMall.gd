extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	Global.level_playing = name.to_lower()
	print(Global.level_playing)
