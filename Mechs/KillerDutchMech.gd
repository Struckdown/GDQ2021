extends Node2D


var missile = preload("res://Projectiles/Missile.tscn")
var fireIndex = 0
var health
export(int) var maxHealth = 3
export(NodePath) onready var bossHPRef = get_node(bossHPRef)

# Called when the node enters the scene tree for the first time.
func _ready():
	health = maxHealth


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MissileLauncherTimer_timeout():
	fireMissile()

func fireMissile():
	var m = missile.instance()
	get_viewport().add_child(m)
	match fireIndex:
		0:
			m.global_position = $ArmL/MissileLauncher.global_position
			m.global_rotation = $ArmL/MissileLauncher.global_rotation
		1:
			m.global_position = $ArmR/MissileLauncher.global_position
			m.global_rotation = $ArmR/MissileLauncher.global_rotation
	fireIndex = (fireIndex + 1) % 2

func takeDamage():
	health -= 1
	if bossHPRef:
		bossHPRef.setHealth(float(health)/float(maxHealth))
	print("Mech has taken damage!")
