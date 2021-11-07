extends Node2D

var playingSong = "intro"

# Called when the node enters the scene tree for the first time.
func _ready():
	CameraManager.cameraRef = $Dodo/Camera2D
	#BGM.requestSong("res://BGM/GDQ - 2021 - BGM Phase 1 - Intro.mp3")
	BGM.requestSong("res://BGM/GDQ - 2021 - BGM Phase 2 - Intro.mp3")
	var err = BGM.connect("finished", self, "_on_BGM_finished")
	if err:
		print("Error:", err)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_BGM_finished():
	match playingSong:
		"intro":
			#BGM.requestSong("res://BGM/GDQ - 2021 - BGM Phase 1 - Main 1.mp3", 0, 0)
			BGM.requestSong("res://BGM/GDQ - 2021 - BGM Phase 2 - Main.mp3", 0, 0)
			playingSong = "main"
		"main":
			pass	# keep playing the same song


func _on_Dodo_died():
	$Other/GameOver.startGameOver()
