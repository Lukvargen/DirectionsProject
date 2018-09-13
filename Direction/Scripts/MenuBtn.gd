extends Button


func _on_MenuBtn_pressed():
	print("MenuBtnPressed")
	#get_tree().change_scene_to(menu)
	Global.goto_menu()
	#get_tree().change_scene("res://Scenes/Playable/Menu.tscn")
	pass # replace with function body
