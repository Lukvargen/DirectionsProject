extends PanelContainer

var star_full = preload("res://Sprites/StarFull.png")


func _ready():
	Global.connect("level_completed",self, "level_completed")
	pass

func level_completed(stars):
	for star in $VBoxContainer/Stars.get_children():
		if stars > 0:
			star.texture = star_full
			stars -= 1
	show()
	pass

func _on_NextLevelBtn_pressed():
	Global.next_level()
	pass # replace with function body


func _on_MenuBtn_pressed():
	#get_tree().change_scene_to(menu)
	Global.goto_menu()
	pass # replace with function body
