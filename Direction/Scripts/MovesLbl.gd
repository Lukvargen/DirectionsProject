extends Label

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	Global.player.get_ref().connect("moved", self, "update_moves")
	pass

func update_moves(moves):
	text = "Moves: " + str(moves)