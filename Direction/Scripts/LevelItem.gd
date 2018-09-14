extends PanelContainer

var star_full = preload("res://Sprites/StarFull.png")

var level_id
var parent

func init(level_id, parent):
	self.level_id = level_id
	self.parent = parent
	
	# Label
	$VBoxContainer/LevelNameLbl.text = "Level " +  level_id.split("level", false)[0]
	
	# Highscore
	$VBoxContainer/HBoxContainer/MovesHighscoreLbl.text = "Moves: " + str(Global.levels[level_id].highscore.moves)
	$VBoxContainer/HBoxContainer/TimeHighscoreLbl.text = "Time: " + str(Global.levels[level_id].highscore.time).pad_decimals(2)
	
	# Texture
	$VBoxContainer/PanelContainer/TextureButton.texture_normal = Global.levels[level_id].icon
	
	# Stars
	var stars = Global.levels[level_id].stars
	for star in $VBoxContainer/Stars.get_children():
		if stars > 0:
			star.texture = star_full
			stars -= 1



func _on_TextureButton_pressed():
	if parent.can_press_button():
		print("Press")
		# Play camera animation
		var img_pos = $VBoxContainer/PanelContainer/TextureButton.rect_global_position
		get_tree().get_root().get_node("Menu/Camera2D").level_transition(img_pos, level_id)
		
		#Global.goto_level(level_id)
