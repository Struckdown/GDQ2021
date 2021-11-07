extends Sprite


var missile = preload("res://Projectiles/Missile.tscn")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _exit_tree():
	queue_free()

func _on_Shoot_timeout():
	print("Hi")
	var m = missile.instance()
	get_viewport().add_child(m)
	m.speed *= 1
	var l = self.global_position
	m.global_position = l
#	m.global_rotation = l.global_rotation
	
