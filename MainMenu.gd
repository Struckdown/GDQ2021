extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ControllerConatiner.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$ControllerConatiner.hide()
		$MenuButtons.show()

func _on_PlayButton_pressed():
	SceneTransition.transitionTo("res://MainLevel.tscn")

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
