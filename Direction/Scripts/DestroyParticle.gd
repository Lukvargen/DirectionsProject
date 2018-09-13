extends Particles2D


func _ready():
	emitting = true
	$Timer.wait_time = lifetime / speed_scale
	$Timer.start()
	pass


func _on_Timer_timeout():
	queue_free()
	pass # replace with function body
