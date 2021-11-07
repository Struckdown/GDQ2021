extends Sprite


var missile = preload("res://Projectiles/Missile.tscn")
export(float) var max_distance = 450


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _exit_tree():
	queue_free()

func _on_Shoot_timeout():
	var dodo_position = get_parent().get_parent().get_node("Dodo").global_position
	# if further than some dist do not shoot
	if global_position.distance_to(dodo_position) < max_distance:
		print(global_position.distance_to(dodo_position))
		var m = missile.instance()
		get_viewport().add_child(m)
		m.speed *= 1
		var l = self.global_position
		m.global_position = l
		m.global_rotation = get_angle_to(dodo_position) + get_parent().global_rotation
	
