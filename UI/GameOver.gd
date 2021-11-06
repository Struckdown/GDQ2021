extends Control

var played = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("restart"):
		restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startGameOver():
	if not played:
		played = true
		get_tree().paused = true
		$CenterContainer/AnimationPlayer.play("display")

func restart():
	get_tree().paused = false
	queue_free()
#	get_tree().change_scene_to(load(get_tree().get_current_scene().get_name()))
	get_tree().reload_current_scene()
