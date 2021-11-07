extends Node2D


var missile = preload("res://Projectiles/Missile.tscn")
var health
export(int) var maxHealth = 3
export(NodePath) onready var bossHPRef = get_node(bossHPRef)
var dodo
export(Array, NodePath) var missileLaunchers
var invulnerable = false
#var state_machine = $AnimationTree["parameters/playback"]
var bossAggressionMultiplier = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth
	dodo = get_tree().get_nodes_in_group("Player")[0]

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MissileLauncherTimer_timeout():
	fireMissile()

func fireMissile():
	var m = missile.instance()
	get_viewport().add_child(m)
	m.speed *= bossAggressionMultiplier
	var l = getClosestLauncherToDodo()
	m.global_position = l.global_position
	m.global_rotation = l.global_rotation

func takeDamage():
	if invulnerable:
		return
	$InvulnerableAnimationPlayer.play("invulnerable")
	invulnerable = true
	health -= 1
	if bossHPRef:
		bossHPRef.setHealth(float(health)/float(maxHealth))
	bossAggressionMultiplier += .5
	var i = health + 1
	$HitSFX.stream = load("res://SFX/Angry Robot " + str(i) + ".mp3")
	$HitSFX.play()
	print("Mech has taken damage!")

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


func _on_InvulnerableAnimationPlayer_animation_finished(anim_name):
	invulnerable = false
	swatHand()

func swatHand():
	$AnimationTree.get("parameters/playback").travel("batLHand")

