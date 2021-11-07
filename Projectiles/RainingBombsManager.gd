extends Node2D

var bomb = preload("res://Projectiles/Bomb.tscn")
var dodoRef
var levelRef

# Called when the node enters the scene tree for the first time.
func _ready():
	dodoRef = get_tree().get_nodes_in_group("Player")[0]
	levelRef = get_tree().get_nodes_in_group("Level")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startRainingBombs(multiplier=1):
	print("raining starting")
	for _i in range(20*multiplier):
		var b = bomb.instance()
		b.rotation_degrees = 90	# face downwards
		var rect = get_viewport_rect().size
		var x = randi() % int(rect.x) * 2 - rect.x
		b.global_position = Vector2(dodoRef.global_position.x + x, dodoRef.global_position.y - 800)
		b.speed *= 1+((multiplier-1)*0.3)
		levelRef.add_child(b)
		yield(get_tree().create_timer(0.2), "timeout")
		
