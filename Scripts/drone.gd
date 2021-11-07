extends KinematicBody2D

export(float) var MAX_THRUST = 50
export(int) var MAX_SPEED = 350
var vel = Vector2()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func cal(delta):
	var player_pos = get_parent().get_node("Dodo").global_position
	var distance_to_player = global_position.distance_to(player_pos)
	var vector_to_player = (player_pos - position).normalized()
	
#	print(player_pos, get_angle_to(player_pos))
	rotation += (get_angle_to(player_pos) + PI/2)
	
#	print(vel, vel.length())

	# FROM https://gravityace.com/devlog/drone-ai/
	# rays
	var closest_collision = null
	$rays.rotation += delta * 11 * PI
	for ray_single in $rays.get_children():
		if ray_single.is_colliding():
			var collision_point = ray_single.get_collision_point() - global_position
			if closest_collision == null:
				closest_collision = collision_point
			if collision_point.length() < closest_collision.length():
				closest_collision = collision_point

	# Dodge
	if closest_collision:
		var normal = -closest_collision.normalized()
		var dodge_direction = 1
		if randf() < 0.5:
			dodge_direction = -1
		vel += normal * MAX_THRUST * 2 * delta
		vel += normal.rotated(PI/2 * dodge_direction) * MAX_THRUST * delta

	if (distance_to_player > 300):
		vel += vector_to_player * MAX_THRUST * delta
	else:
		vel += -vector_to_player * MAX_THRUST * delta
		
	# cap max speed
	if vel.length() > MAX_SPEED:
		vel = vel.normalized() * MAX_SPEED

func _physics_process(delta):
	cal(delta)
	vel = move_and_slide(vel)
