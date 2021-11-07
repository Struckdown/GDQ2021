extends Node2D

var drone = preload("res://Drone.tscn")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Spawn_Drone_timeout():
	var dodo_pos = get_parent().get_node("Dodo").global_position
	var best_position = $positions.get_children()[0].global_position
	var best_dist = best_position.distance_to(dodo_pos)
	for position in $positions.get_children():
		var dist = position.global_position.distance_to(dodo_pos)
		if dist < best_dist:
			best_dist = dist
			best_position = position.global_position

	# spawn
	var e = drone.instance()
	get_parent().add_child(e)
	print(best_position)
	e.global_position = best_position
