extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event.is_action_pressed("Pause"):
		var is_paused = not get_tree().paused
		get_tree().paused = is_paused
		visible = is_paused

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_resume_pressed():
	get_tree().paused = not get_tree().paused


func _on_quit_pressed():
	get_tree().quit()
