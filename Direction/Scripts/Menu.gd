extends Node2D

func _ready():
	Global.load_game()
	
	print("Global.stars",Global.stars)
	$Control/StarsLbl.text = "Stars: " + str(Global.stars)


func _on_MoveCamera_body_entered(body):
	if body.is_in_group("Player"):
		$Camera2D.move_camera(body.direction)



func _on_Continue_body_entered(body):
	if body.is_in_group("Player"):
		Global.continue_level()

