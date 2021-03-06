extends Node2D


var missile = preload("res://Projectiles/Missile.tscn")
var bombFake = preload("res://Projectiles/BombFake.tscn")
var health
export(int) var maxHealth = 3
export(float) var moveSpeed = 100
export(NodePath) onready var bossHPRef = get_node(bossHPRef)
var dodo
export(Array, NodePath) var missileLaunchers
var invulnerable = false
export(NodePath) onready var navigation2D = get_node(navigation2D)
export(NodePath) onready var bombsManager = get_node(bombsManager)
var dest = Vector2.ZERO
var bossAggressionMultiplier = 1
var explosionParticles = preload("res://Mechs/ExplosionParticle.tscn")
export(String, "missiles", "bombs") var state = "missiles"

export(float) var swatCooldownMax = 15.0
var swatCooldown = 0
export(bool) var handsCanHurt = false
var levelRef

signal died

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	dodo = get_tree().get_nodes_in_group("Player")[0]
	levelRef = get_tree().get_nodes_in_group("Level")[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move(delta)
	swatCooldown -= delta

func move(delta):
	global_position -= (global_position-dest).normalized() * moveSpeed * delta

func _on_MissileLauncherTimer_timeout():
	if state == "missiles":
		$AnimationTree.get("parameters/playback").travel("FireMissile")

func fireMissile():
	var l = getClosestLauncherToDodo()
	var m = missile.instance()
	levelRef.add_child(m)
	m.speed *= bossAggressionMultiplier
	m.global_position = l.global_position
	m.global_rotation = l.get_angle_to(dodo.global_position)
	l.get_child(0).emitting = true
	$MissileLaunchedSFX.play()


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
		levelRef.add_child(e)
		var r = 500 * sqrt(randf())
		var theta = randf() * 2 * PI
		var pos = Vector2(global_position.x + r*cos(theta), global_position.y + r*sin(theta))
		e.global_position = pos
		e.emitting = true
		e.get_child(0).emitting = true
		yield(get_tree().create_timer(0.05), "timeout")
	emit_signal("died")

func _on_InvulnerableAnimationPlayer_animation_finished(_anim_name):
	invulnerable = false
	swatHand()

func swatHand():
	$AnimationTree.get("parameters/playback").travel("batLHand")


func _on_ChaseTimer_timeout():
	dest = navigation2D.get_closest_point(dodo.global_position)
#		$Navigation2D.get_closest_point()

func fireBombs(isLeft):
	var pos
	if isLeft:
		pos = $UpperArmL/ArmL/HandL/Position2DFinger
	else:
		pos = $UpperArmR/ArmR/HandR/Position2DFinger
	var m = bombFake.instance()
	levelRef.add_child(m)
	m.speed *= bossAggressionMultiplier
	m.global_position = pos.global_position
	m.global_rotation = pos.global_rotation
	pos.get_child(0).emitting = true
	$MissileLaunchedSFX.play()

func _on_PhaseTimer_timeout():
	match state:
		"missiles":
			state = "bombs"
			$AnimationTree.get("parameters/playback").travel("FireBombsUpwards")
		"bombs":
			state = "missiles"


func activeBombManager():
	bombsManager.startRainingBombs(bossAggressionMultiplier)


func _on_AboveHeadArea_body_entered(body):
	if body.is_in_group("Player") and swatCooldown <= 0:
		$AnimationTree.get("parameters/playback").travel("SwatHead")
		swatCooldown = swatCooldownMax


func _on_HurtBoxHand_body_entered(body):
	if body.is_in_group("Player") and handsCanHurt:
		body.takeDamage()
		
