extends Label

export(int) var timer_value = 0
export(bool) var is_paused = false
onready var start_time = OS.get_ticks_msec()

# Declare member variables here. Examples:
# var a = 2
var prefix = "Timer: "


# Called when the node enters the scene tree for the first time.
func _ready():
	start_time = OS.get_ticks_msec()

func _process(delta):
	if (not is_paused):
		var time = (OS.get_ticks_msec() - start_time) / 10
		timer_value = time
		var milli = time / 10
		var seconds = (milli / 10) % 100
		var minutes = (seconds / 60) % 60
		self.text = prefix + "%0*d" % [2, minutes] + ':' + "%0*d" % [2, seconds] + ':' + str(milli)[-1]
	

func on_pause():
	is_paused = true

func toggle_pause():
	is_paused = not is_paused
	
func reset():
	start_time = OS.get_ticks_msec()
	# we can change this later
	is_paused = false


func _on_Shoot_timeout():
	pass # Replace with function body.
