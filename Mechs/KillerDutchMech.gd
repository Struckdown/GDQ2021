extends Node2D


var missile = preload("res://Projectiles/Missile.tscn")
var health
export(int) var maxHealth = 3
export(float) var moveSpeed = 100
export(NodePath) onready var bossHPRef = get_node(bossHPRef)
var dodo
export(Array, NodePath) var missileLaunchers
var invulnerable = false
export(NodePath) onready var navigation2D = get_node(navigation2D)
var dest = Vector2.ZERO
var bossAggressionMultiplier = 1
var explosionParticles = preload("res://Mechs/ExplosionParticle.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	dodo = get_tree().get_nodes_in_group("Player")[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)

func move(delta):
	global_position -= (global_position-dest).normalized() * moveSpeed * delta

func _on_MissileLauncherTimer_timeout():
	fireMissile()

func fireMissile():
	var l = getClosestLauncherToDodo()
	$UpperArmL/ArmL/HandL.texture = load("res://art/spr_handspoint.png")
	$UpperArmR/ArmR/HandR.texture = load("res://art/spr_handspoint.png")
	yield(get_tree().create_timer(1), "timeout")
	var m = missile.instance()
	get_viewport().add_child(m)
	m.speed *= bossAggressionMultiplier
	m.global_position = l.global_position
	m.global_rotation = l.global_rotation
	l.get_child(0).emitting = true
	yield(get_tree().create_timer(0.4), "timeout")
	$MissileLaunchedSFX.play()
	$UpperArmL/ArmL/HandL.texture = load("res://art/spr_hands.png")
	$UpperArmR/ArmR/HandR.texture = load("res://art/spr_hands.png")


func takeDamage():
	if invulnerable:
		return
	$InvulnerableAnimationPlayer.play("invulnerable")
	invulnerable = true
	health -= 1
	if bossHPRef:
		bossHPRef.setHealth(float(health)/float(maxHealth))
	bossAggressionMultiplier += .5
	var i = randi()%3
	$HitSFX.stream = load("res://SFX/Angry Robot " + str(i+1)  + ".mp3")
	$HitSFX.play()
	if health <= 2:
		$Head.texture = load("res://art/spr_headangry.png")
	if health <= 0:
		die()


func getClosestLauncherToDodo():
	var closest = null
	var closestDist = null
	for child in missileLaunchers:
		child = get_node(child)
		var dist = child.global_position.distance_squared_to(dodo.global_position)
		if closest == null:
			closestDist = dist
			closest = child
		else:
			if dist < closestDist:
				closestDist = dist
				closest = child
	return closest

func die():
	for _i in range(15):
		var e = explosionParticles.instance()
		get_viewport().add_child(e)
		var r = 500 * sqrt(randf())
		var theta = randf() * 2 * PI
		var pos = Vector2(global_position.x + r*cos(theta), global_position.y + r*sin(theta))
		e.global_position = pos
		e.emitting = true
		e.get_child(0).emitting = true
		yield(get_tree().create_timer(0.05), "timeout")

func _on_InvulnerableAnimationPlayer_animation_finished(_anim_name):
	invulnerable = false
	swatHand()

func swatHand():
	$AnimationTree.get("parameters/playback").travel("batLHand")



func _on_ChaseTimer_timeout():
	dest = navigation2D.get_closest_point(dodo.global_position)
#		$Navigation2D.get_closest_point()

