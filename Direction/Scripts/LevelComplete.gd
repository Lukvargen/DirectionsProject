extends PanelContainer

var star_full = preload("res://Sprites/StarFull.png")


func _ready():
	Global.connect("level_completed",self, "level_completed")
	pass

func level_completed(stars):
	var level = Global.levels[Global.level_playing]
	var level_nr = Global.level_playing.split("level",false)[0]
	$VBoxContainer/LevelLbl.text = "Level: " + str(level_nr) + " Completed!"
	
	$VBoxContainer/HighscoreContainer/VBoxContainer/MovesHighscore.text = "Moves: " + str(level.highscore.moves)
	$VBoxContainer/HighscoreContainer/VBoxContainer/TimeHighscore.text = "Time: " + str(level.highscore.time).pad_decimals(2)
	
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
