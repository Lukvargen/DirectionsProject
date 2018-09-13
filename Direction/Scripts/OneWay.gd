tool
extends StaticBody2D

export(Vector2) var direction = Vector2(1,0) setget set_direction

func _ready():
	get_parent().get_node("Player").connect("direction_changed", self, "player_move")
	pass


func player_move(player_dir):
	if direction == player_dir:
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
	pass


func set_direction(new_dir):
	direction = new_dir
	$Sprite.rotation = direction.angle()

