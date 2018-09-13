extends Sprite

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	
	pass

func _process(delta):
	modulate.a -= delta * 3



func _on_Timer_timeout():
	queue_free()
