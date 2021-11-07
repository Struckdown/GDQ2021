extends Control

var pausingAllowed = true


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if not pausingAllowed:
		return
	if event.is_action_pressed("pause"):
		var is_paused = not get_tree().paused
		get_tree().paused = is_paused
		visible = is_paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_resume_pressed():
	$ClickSFX.play()
	var is_paused = not get_tree().paused
	get_tree().paused = is_paused
	visible = is_paused


func _on_quit_pressed():
	$ClickSFX.play()
	get_tree().quit()


func _on_Button_mouse_entered():
	$HoverSFX.play()
