extends KinematicBody2D


export(float) var speed = 600
export(float) var maxSpeed = 900
var dragFactor = 0.1
var heldDirections = Vector2(0,0)	# x,y (x is left/right)
var velocity = Vector2(0,0)
var gravity = 9.81


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	determineInputs()
	applyMovement(delta)

func determineInputs():
	heldDirections[0] = (-1 * int(Input.is_action_pressed("left"))) + int(Input.is_action_pressed("right"))
	heldDirections[1] = (-1 * int(Input.is_action_pressed("up"))) + int(Input.is_action_pressed("down"))
	

func applyMovement(delta):
	#velocity[0] *= dragFactor
	velocity[0] = clamp(heldDirections[0]*speed*delta, -maxSpeed, maxSpeed)
	velocity[1] = clamp(velocity[1] + gravity*delta, -100, 200)
	move_and_slide(velocity*50)

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		velocity[1] -= 20
