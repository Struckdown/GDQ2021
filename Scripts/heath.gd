extends HBoxContainer

export(int) var health = 3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	redraw_health()

func redraw_health():
	if health == 0:
		$feather.visible = false
		$feather2.visible = false
		$feather3.visible = false
		$feather_empty.visible = true
		$feather_empty2.visible = true
		$feather_empty3.visible = true
	elif health == 1:
		$feather.visible = true
		$feather2.visible = false
		$feather3.visible = false
		$feather_empty.visible = false
		$feather_empty2.visible = true
		$feather_empty3.visible = true
	elif health == 2:
		$feather.visible = true
		$feather2.visible = true
		$feather3.visible = false
		$feather_empty.visible = false
		$feather_empty2.visible = false
		$feather_empty3.visible = true
	elif health == 3:
		$feather.visible = true
		$feather2.visible = true
		$feather3.visible = true
		$feather_empty.visible = false
		$feather_empty2.visible = false
		$feather_empty3.visible = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func hit():
	health-=1
	redraw_health()

func heal():
	health+=1
	redraw_health()

func heal_full():
	health = 3
	redraw_health()
	
func change_health(new_health):
	health = new_health
	redraw_health()
	
