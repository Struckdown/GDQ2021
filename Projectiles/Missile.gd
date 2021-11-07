extends Node2D

export(float) var speed = 300
export(float) var turnRate = 3
var target
var dying = false
export(bool) var shouldTrack = true
var explosionParticle = preload("res://Mechs/ExplosionParticle.tscn")
export(bool) var explodes = true
export(bool) var hasSpawnSFX = false

# Called when the node enters the scene tree for the first time.
func _ready():
	if shouldTrack:
		target = get_tree().get_nodes_in_group("missileTrackable")[0]
	if hasSpawnSFX:
		$SpawnSFX.play()



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)


func move(delta):
	var desiredRotation = rotation_degrees
	if is_instance_valid(target):
		desiredRotation = rad2deg(get_angle_to(target.global_position))
	rotation_degrees += sign(desiredRotation) * min(abs(desiredRotation), turnRate)

	var velocity = Vector2(1,0).rotated(rotation)
	position += velocity*delta*speed


func _on_Area2D_body_entered(body):
	if body.is_in_group("canBeHitByMissiles"):
		if body.has_method("takeDamage"):
			body.takeDamage()
			explode()
		else:
			var o = body.owner
			if o.has_method("takeDamage"):
				o.takeDamage()
				explode()


func _on_Lifetime_timeout():
	if has_node("TimeoutAnimPlayer"):
		$TimeoutAnimPlayer.play("Timeout")
	else:
		explode()

func explode():
	if not dying:
		dying = true
		if explodes:
			$AudioStreamPlayer.play()
			$ExplosionTimer.start()
			$Area2D/CollisionShape2D.set_deferred("disabled", true)
			var e = explosionParticle.instance()
			e.global_position = global_position
			get_viewport().add_child(e)
		$Sprite.hide()
		

func _on_ExplosionTimer_timeout():
	queue_free()


func _on_TimeoutAnimPlayer_animation_finished(_anim_name):
	explode()
