extends Control

var played = false
signal gameOver

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _input(event):
	if event.is_action_pressed("restart"):
		restart()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func startGameOver():
	if not played:
		emit_signal("gameOver")
		played = true
		$DelayTimer.start()

		
func restart():
	get_tree().paused = false
	SceneTransition.transitionTo("res://MainLevel.tscn")


func _on_DelayTimer_timeout():
	get_tree().paused = true
	$CenterContainer/AnimationPlayer.play("display")
