extends Node2D

export(String) var levelToTransitionTo = "res://MainLevel.tscn"
export(String) var songToRequest = "res://BGM/GDQ - 2021 - BGM Phase 1 - End 2.mp3"

# Called when the node enters the scene tree for the first time.
func _ready():
	if songToRequest:
		BGM.requestSong(songToRequest, 0.2, 0.2)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimationPlayer_animation_finished(_anim_name):
	SceneTransition.transitionTo(levelToTransitionTo)
