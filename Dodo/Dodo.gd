extends KinematicBody2D


export(float) var speed = 600
export(float) var maxSpeed = 900
var dragFactor = 0.1
var heldDirections = Vector2(0,0)	# x,y (x is left/right)
var velocity = Vector2(0,0)
var gravity = 9.81
var dashRequested = false
var dashTimeLeft = 0
var dashTimeCap = 0.2	# seconds
var dashSpeed = 800
var wasDashing = false
var facingRight = 1	# either 1 or -1
var anim

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
	dashRequested = Input.is_action_just_pressed("dash")
	

func applyMovement(delta):
	if heldDirections[0] > 0:
		facingRight = 1
		$Sprite.flip_h = false
		updateAnim("run")
	elif heldDirections[0] < 0:
		facingRight = -1
		$Sprite.flip_h = true
		updateAnim("run")
	else:
		updateAnim("idle")

	if dashRequested:
		if heldDirections[0] == 0 and heldDirections[1] == 0:
			heldDirections[0] = facingRight
		velocity = heldDirections * dashSpeed * delta
		dashTimeLeft = dashTimeCap
		wasDashing = true
	if dashTimeLeft > 0:
		pass
	else:
		if wasDashing:
			wasDashing = false
			velocity[1] = max(-3, velocity[1])
		velocity[0] = clamp(heldDirections[0]*speed*delta, -maxSpeed, maxSpeed)
		velocity[1] = clamp(velocity[1] + gravity*delta, -100, 200)
		if is_on_floor():
			velocity[1] = clamp(velocity[1], -100, 0)
	move_and_slide(velocity*50, Vector2(0, -1))
	dashTimeLeft -= delta

func updateAnim(newAnim):
	if newAnim == anim:
		return
	$AnimationPlayer.play(newAnim)
	anim = newAnim
	

func _unhandled_input(event):
	if event.is_action_pressed("jump") and is_on_floor():
		velocity[1] -= 9

func takeDamage():
	print("Dodo was hit!")
