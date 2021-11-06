extends Node2D

export(float) var speed = 300
export(float) var turnRate = 3
var target
var dying = false

# Called when the node enters the scene tree for the first time.
func _ready():
	target = get_tree().get_nodes_in_group("missileTrackable")[0]


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)


func move(delta):
	var desiredRotation = rotation_degrees
	if target:
		desiredRotation = rad2deg(get_angle_to(target.global_position))
	rotation_degrees += sign(desiredRotation) * min(abs(desiredRotation), turnRate)

	var velocity = Vector2(1,0).rotated(rotation)
	position += velocity*delta*speed


func _on_Area2D_body_entered(body):
	if body.is_in_group("canBeHitByMissiles"):
		body.takeDamage()
		explode()


func _on_Lifetime_timeout():
	explode()

func explode():
	if not dying:
		dying = true
		$AudioStreamPlayer.play()
		$ExplosionTimer.start()
		$Area2D/CollisionShape2D.set_deferred("disabled", true)
		$icon.hide()


func _on_ExplosionTimer_timeout():
	queue_free()
