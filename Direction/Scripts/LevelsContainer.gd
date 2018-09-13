extends ScrollContainer

var level_item = preload("res://Scenes/LevelItem.tscn")

var mouse_hold = false

var mouse_press_posX
var mouse_hold_posX
var can_press = false

var mouse_prev_posX = 0
var mouse_posX = 0
var difference = 0

var scroll_speed = 0

func _ready():
	Global.connect("player_loaded", self, "player_loaded")
	"""
	for level_id in Global.levels:
		var new_level_item = level_item.instance()
		$HBoxContainer.add_child(new_level_item)
		new_level_item.init(level_id, self)
	"""


func player_loaded():
	for level_id in Global.levels:
		var new_level_item = level_item.instance()
		$HBoxContainer.add_child(new_level_item)
		new_level_item.init(level_id, self)



func _input(event):
	if event.is_action_pressed("click"):
		if Rect2(rect_global_position,rect_size).has_point(get_global_mouse_position()):
			mouse_prev_posX = get_global_mouse_position().x
			mouse_hold = true
			
			can_press = true
			mouse_press_posX = get_global_mouse_position().x
			
	if event.is_action_released("click"):
		mouse_hold = false
		scroll_speed = difference
	
	if mouse_hold:
		mouse_posX = get_global_mouse_position().x
		difference =  mouse_prev_posX - mouse_posX
		scroll_horizontal += difference
		mouse_prev_posX = mouse_posX
		
		if abs(mouse_posX - mouse_press_posX) > 5:
			can_press = false



func _process(delta):
	scroll_horizontal += scroll_speed
	scroll_speed = lerp(scroll_speed, 0, 0.1)
	if abs(scroll_speed) < 0.05:
		scroll_speed = 0


func can_press_button():
	return can_press
