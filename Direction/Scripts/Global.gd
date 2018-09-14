extends Node2D

var player

const SAVE_PATH = "user://DirectionsSave.json"
# "res://save.json" kanske test

var level_playing = "level1"
var stars = 0


signal level_completed
signal player_loaded

var menu = preload("res://Scenes/Playable/Menu.tscn")
var levels = {
	level1 = {
		scene = preload("res://Scenes/Playable/Level1.tscn"),
		icon = preload("res://Sprites/Scenes/level1screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 10,
			2: 7,
			3: 5,
		},
		stars = 0,
	},
	level2 = {
		scene = preload("res://Scenes/Playable/Level2.tscn"),
		icon = preload("res://Sprites/Scenes/level2screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 10,
			2: 8,
			3: 7,
		},
		stars = 0,
	},
	level3 = {
		scene = preload("res://Scenes/Playable/Level3.tscn"),
		icon = preload("res://Sprites/Scenes/level3screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 6,
			2: 5,
			3: 4,
		},
		stars = 0,
	},
	level4 = {
		scene = preload("res://Scenes/Playable/Level4.tscn"),
		icon = preload("res://Sprites/Scenes/level4screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 10,
			2: 8,
			3: 6,
		},
		stars = 0,
	},
	level5 = {
		scene = preload("res://Scenes/Playable/Level5.tscn"),
		icon = preload("res://Sprites/Scenes/level5screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 10,
			2: 7,
			3: 4,
		},
		stars = 0,
	},
	level6 = {
		scene = preload("res://Scenes/Playable/Level6.tscn"),
		icon = preload("res://Sprites/Scenes/level6screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 8,
			2: 7,
			3: 6,
		},
		stars = 0,
	},
	level7 = {
		scene = preload("res://Scenes/Playable/Level7.tscn"),
		icon = preload("res://Sprites/Scenes/level7screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 8,
			2: 6,
			3: 4,
		},
		stars = 0,
	},
	level8 = {
		scene = preload("res://Scenes/Playable/Level8.tscn"),
		icon = preload("res://Sprites/Scenes/level8screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 12,
			2: 9,
			3: 6,
		},
		stars = 0,
	},
	level9 = {
		scene = preload("res://Scenes/Playable/Level9.tscn"),
		icon = preload("res://Sprites/Scenes/level9screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 8,
			2: 6,
			3: 5,
		},
		stars = 0,
	},
	level10 = {
		scene = preload("res://Scenes/Playable/Level10.tscn"),
		icon = preload("res://Sprites/Scenes/level10screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 10,
			2: 8,
			3: 7,
		},
		stars = 0,
	},
	level11 = {
		scene = preload("res://Scenes/Playable/Level11.tscn"),
		icon = preload("res://Sprites/Scenes/level11screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 8,
			2: 6,
			3: 4,
		},
		stars = 0,
	},
	level12 = {
		scene = preload("res://Scenes/Playable/Level12.tscn"),
		icon = preload("res://Sprites/Scenes/level12screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 9,
			2: 8,
			3: 6,
		},
		stars = 0,
	},
	level13 = {
		scene = preload("res://Scenes/Playable/Level13.tscn"),
		icon = preload("res://Sprites/Scenes/level13screenshot.png"),
		completed = false,
		highscore = {
			moves = 0,
			time = 0,
		},
		moves_needed = {
			1: 7,
			2: 6,
			3: 5,
		},
		stars = 0,
	},
}



signal swipe
var swipe_start = null
var minimum_drag = 10

# Swipe
func _unhandled_input(event):
	if event.is_action_pressed("click"):
		swipe_start = get_global_mouse_position()
	elif event.is_action_pressed("restart"):
		reload_scene()
	elif event.is_action_pressed("screenshot"):
		screen_shot()
	elif event.is_action_pressed("next_level"):
		print("next_lvl")
		next_level()
	
	if event.is_action_released("click"):
		_calculate_swipe(get_global_mouse_position())
	

        
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	
	if swipe.length() > minimum_drag:
		if swipe.normalized().dot(Vector2(1,0)) > 0.5:
			emit_signal("swipe", "right")
		elif swipe.normalized().dot(Vector2(-1,0)) > 0.5:
			emit_signal("swipe", "left")
		elif swipe.normalized().dot(Vector2(0,1)) > 0.5:
			emit_signal("swipe", "down")
		elif swipe.normalized().dot(Vector2(0,-1)) > 0.5:
			emit_signal("swipe", "up")

func screen_shot():
	# Let two frames pass to make sure the screen was captured
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	# Retrieve the captured image
	var img = get_viewport().get_texture().get_data()
	
	# Flip it on the y-axis (because it's flipped)
	img.flip_y()

	# get screen capture
	#var capture = get_viewport().get_screen_capture()
	# save to a file
	img.save_png("C://Users//lukas//OneDrive//Dokument//Godot//Direction//Sprites//Scenes//Menuscreenshot.png")
	print("Screenshot")


# Win
func win(moves, time):
	var level = levels[level_playing]
	if not level.completed:
		level.highscore.moves = moves
		level.highscore.time = time
		level.completed = true
	else:
		if moves < level.highscore.moves:
			level.highscore.moves = moves
			level.highscore.time = time
		elif moves == level.highscore.moves:
			level.highscore.time = time
	
	var reached_star = 0
	for star in level.moves_needed:
		if moves <= level.moves_needed[star]:
			reached_star = star
	if reached_star > level.stars:
		stars += reached_star - level.stars
		level.stars = reached_star
	emit_signal("level_completed", reached_star)
	
	save_game()


func next_level():
	print("Next Level")
	var current_level_number = int(level_playing.split("level",false)[0])
	var next_level = "level"+ str(current_level_number+1)
	if levels.has(next_level):
		level_playing = next_level
		if player.get_ref():
			player.get_ref().dont_destroy_outside = true
		get_tree().change_scene_to(levels[level_playing].scene)



func continue_level():
	print("Continue")
	get_tree().change_scene_to(levels[level_playing].scene)

func reload_scene():
	print("Reload")
	get_tree().reload_current_scene()

func goto_menu():
	print("GOTO menu")
	if player.get_ref():
		player.get_ref().dont_destroy_outside = true
	get_tree().change_scene_to(menu)

func goto_level(level):
	print("goto level " + level)
	level_playing = level
	var scene = levels[level].scene
	get_tree().change_scene_to(scene)


func save_game():
	var save_file = File.new()
	
	# Behövs spara: Levelid {highscore, stars, completed}
	
	var save_data = {}
	save_data.level_playing = level_playing
	save_data.stars = stars
	save_data.levels = {}
	
	for level_id in levels:
		var level = levels[level_id]
		save_data.levels[level_id] = {}
		var save_level = save_data.levels[level_id]
		
		save_level.highscore = level.highscore
		save_level.stars     = level.stars
		save_level.completed = level.completed
	
	
	save_file.open(SAVE_PATH, File.WRITE)
	
	save_file.store_line(to_json(save_data))
	print ("Saved")
	save_file.close()


func load_game():
	
	var save_file = File.new()
	if !save_file.file_exists(SAVE_PATH):
		print ("No save")
		emit_signal("player_loaded")
		return
	
	var currentline = {}
	save_file.open(SAVE_PATH, File.READ)
	currentline = parse_json(save_file.get_line())
	
	level_playing = currentline.level_playing
	if currentline.has("stars"):
		stars = currentline.stars
	for level_id in currentline.levels:
		var loaded_level = currentline.levels[level_id]
		var local_level = levels[level_id]
		
		local_level.highscore = loaded_level.highscore
		local_level.stars     = loaded_level.stars
		local_level.completed = loaded_level.completed
	
	print("loaded successfully")
	save_file.close()
	emit_signal("player_loaded")



func delete_save():
	var dir = Directory.new()
	dir.remove(SAVE_PATH)




static func deep_copy(v):
    var t = typeof(v)

    if t == TYPE_DICTIONARY:
        var d = {}
        for k in v:
            d[k] = deep_copy(v[k])
        return d

    elif t == TYPE_ARRAY:
        var d = []
        d.resize(len(v))
        for i in range(len(v)):
            d[i] = deep_copy(v[i])
        return d

    elif t == TYPE_OBJECT:
        if v.has_method("duplicate"):
            return v.duplicate()
        else:
            print("Found an object, but I don't know how to copy it!")
            return v

    else:
        # Other types should be fine,
        # they are value types (except poolarrays maybe)
        return v
