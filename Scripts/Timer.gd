extends Label

export(int) var timer_value = 0
onready var start_time = OS.get_ticks_msec()

# Declare member variables here. Examples:
# var a = 2
var prefix = "Timer: "


# Called when the node enters the scene tree for the first time.
#func _ready():
#	self.text = prefix + str(DisplayValue)

func _process(delta):
	var time = (OS.get_ticks_msec() - start_time) / 10
	timer_value = time
	var milli = time / 10
	var seconds = (milli / 10) % 100
	var minutes = (seconds / 60) % 60
	self.text = prefix + "%0*d" % [2, minutes] + ':' + "%0*d" % [2, seconds] + ':' + str(milli)[-1]
	
