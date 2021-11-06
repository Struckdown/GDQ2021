extends Label

var DisplayValue = 0

# Declare member variables here. Examples:
# var a = 2
var prefix = "Timer: "


# Called when the node enters the scene tree for the first time.
func _ready():
	self.text = prefix + str(DisplayValue)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
