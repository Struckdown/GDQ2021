extends Node2D

var playingSong = "intro"

# Called when the node enters the scene tree for the first time.
func _ready():
	CameraManager.cameraRef = $Dodo/Camera2D
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BGM_finished():
	match playingSong:
		"intro":
			$BGM.stream = load("res://BGM/GDQ - 2021 - BGM Phase 1 - Main 1.mp3")
			playingSong = "main"
		"main":
			pass	# keep playing the same song
	$BGM.play()


func _on_Dodo_died():
	$Other/GameOver.startGameOver()
