extends CanvasLayer

var levelToChangeTo
signal fadeInFinished

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func transitionTo(level):
	$AnimationPlayer.play("FadeOut")
	levelToChangeTo = level


func _on_AnimationPlayer_animation_finished(anim_name):
	match anim_name:
		"FadeOut":
			var err = get_tree().change_scene(levelToChangeTo)
			if err:
				print("Error:", err)
			$AnimationPlayer.play("FadeIn")
		"FadeIn":
			emit_signal("fadeInFinished")
