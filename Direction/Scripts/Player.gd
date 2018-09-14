extends KinematicBody2D

var win_particle = preload("res://Scenes/WinParticle.tscn")
var shadow = preload("res://Scenes/ShadowSprite.tscn")

var moving = false
var direction = Vector2()

var start_speed = 1000
var speed = 1000

var moves = 0

var destroy = false

var dont_destroy_outside = false

var start_timer = false
var time = 0
signal time_changed
signal moved
signal direction_changed

func _ready():
	modulate.a = 0
	Global.player = weakref(self)
	$Tween.interpolate_property(self, "modulate", Color(1,1,1,0), Color(1,1,1,1), 1,Tween.TRANS_QUAD,Tween.EASE_OUT)
	$Tween.start()
	
	if get_parent().name == "Menu":
		dont_destroy_outside = true
	
	Global.connect("swipe", self, "swipe")


func _physics_process(delta):
	if not moving:
		if Input.is_action_pressed("right"):
			change_direction(Vector2(1, 0))
		elif Input.is_action_pressed("left"):
			change_direction(Vector2(-1, 0))
		elif Input.is_action_pressed("down"):
			change_direction(Vector2(0, 1))
		elif Input.is_action_pressed("up"):
			change_direction(Vector2(0, -1))
	else:
		var collision = move_and_collide(direction * speed * delta)
		if collision:
			moving = false
			#modulate = Color(1,1,1,1)
		else:
			speed += delta * 2000
			#modulate = Color(1/(speed/500),1/(speed/500),1,1)
			#if $SpawnShadow.is_stopped():
			#	$SpawnShadow.start()
				#var new_shadow = shadow.instance()
				#get_parent().add_child(new_shadow)
				#new_shadow.global_position = global_position
			
	
	if start_timer:
		if not destroy:
			time+=delta
			emit_signal("time_changed",time)


func swipe(dir):
	if not moving:
		if dir == "right":
			change_direction(Vector2(1, 0))
		elif dir == "left":
			change_direction(Vector2(-1, 0))
		elif dir == "down":
			change_direction(Vector2(0, 1))
		elif dir == "up":
			change_direction(Vector2(0, -1))

func change_direction(dir):
	if direction == dir:
		return
	if start_timer == false:
		start_timer = true
	
	speed = start_speed
	
	direction = dir
	moving = true
	moves += 1
	emit_signal("moved", moves)
	emit_signal("direction_changed", direction)

func win():
	print("Win")
	var new_win_particle = win_particle.instance()
	get_parent().add_child(new_win_particle)
	new_win_particle.global_position = global_position
	Global.win(moves, time)
	destroy = true
	emit_signal("time_changed",time)
	queue_free()
	pass

func stop():
	direction = Vector2(0,0)
	moving = false


func _on_VisibilityNotifier2D_screen_exited():
	if not destroy and not dont_destroy_outside:
		Global.reload_scene()



func _on_SpawnShadow_timeout():
	$SpawnShadow.stop()
	pass # replace with function body
