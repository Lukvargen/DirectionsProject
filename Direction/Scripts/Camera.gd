extends Camera2D

var change_scene_queue = ""


func move_camera(direction):
	$Tween.interpolate_property(self, "position", position, position +Vector2(ProjectSettings.get_setting("display/window/size/width") * direction.x, ProjectSettings.get_setting("display/window/size/height") * direction.y),0.4,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()

func level_transition(img_position, level_id):
	$Tween.interpolate_property(self, "position", position, img_position ,0.4,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	$Tween.interpolate_property(self, "zoom", zoom, Vector2(1,1) * 0.416666 ,0.4,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	
	change_scene_queue = level_id
	pass

func _on_Tween_tween_completed(object, key):
	if change_scene_queue != "":
		Global.goto_level(change_scene_queue)
	pass # replace with function body
