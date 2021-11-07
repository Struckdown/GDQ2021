extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_pos = get_parent().get_node("Dodo").global_position
	var distance_to_player = global_position.distance_to(player_pos)
	var vector_to_player = (player_pos - position).normalized()
	
	print(player_pos)
	rotation = -100
