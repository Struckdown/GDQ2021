extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$ControlRect.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func _input(event):
	if event.is_action_pressed("ui_cancel"):
		$ControlRect.hide()

func _on_PlayButton_pressed():
	get_tree().change_scene("res://MainLevel.tscn")

func _on_QuitButton_pressed():
	get_tree().quit()

func _on_ControlsButton_pressed():
	$ControlRect.show()

func _on_BackButton_pressed():
	$ControlRect.hide()

