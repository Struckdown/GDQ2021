extends AudioStreamPlayer

var curSong = null
var fadingOut = false
var fadeOutTime = 1
var fadeInTime = 0.7
var shouldLoop = true

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func requestSong(track, _fadeOutTime=1, _fadeInTime=0.7):
	if curSong == track:
		return
	curSong = track
	fadeOutTime = _fadeOutTime
	fadeInTime = _fadeInTime
	fadingOut = true
	$Tween.interpolate_property(self, "volume_db",
		0, -80, fadeOutTime,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Tween_tween_all_completed():
	if fadingOut:
		fadingOut = false
		switchTracks()
		fadeIn()
	else:
		pass	# do nothing on finishing fading in

func fadeIn():
		$Tween.interpolate_property(self, "volume_db",
		-80, 0, fadeInTime,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()

func switchTracks():
		stream = load(curSong)
		play()


func _on_BGM_finished():
	if shouldLoop:
		play()
