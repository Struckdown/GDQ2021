extends Node2D

var trauma = 0
var cameraRef

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	trauma *= 0.95
	shake()

func shake():
	if trauma > 0:
		cameraRef.offset = Vector2(randf(), randf()) * trauma*10
		
		
func addTrauma(val):
	trauma += val
