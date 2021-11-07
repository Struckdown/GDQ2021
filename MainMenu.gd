extends Control



# Called when the node enters the scene tree for the first time.
func _ready():
	BGM.requestSong("res://BGM/GDQ - 2021 - BGM - Main Menu Idle Song 1.mp3")
	BGM.shouldLoop = true
	$ControllerConatiner.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$ControllerConatiner.hide()
		$MenuButtons.show()

func _on_PlayButton_pressed():
	SceneTransition.transitionTo("res://UI/IntroCutscene.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ControlsButton_pressed():
	$ControllerConatiner.show()
	$MenuButtons.hide()

func _on_BackButton_pressed():
	$ControllerConatiner.hide()
	$MenuButtons.show()



func _on_Button_focus_entered():
	$ClickSFX.play()


func _on_Button_mouse_entered():
	$HoverSFX.play()


func _on_Credits_pressed():
		SceneTransition.transitionTo("res://Credits.tscn")
