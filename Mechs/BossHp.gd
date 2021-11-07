extends VBoxContainer

var titles = ["Accursed", "Burnt", "Desolate", "Emaciated", "Forsaken", "Holy", "Incorruptible", "Joyless"]
var names = ["William", "Willem", "Maurits", "Frederik", "Jan", "Lodewijk", "Casimir", "Hendrik", "Johan"]
var secondTitles = ["Dismantler", "Undying", "Living Mountain", "Dodo Collector", "Lord of Sin", "Executioner", "Archpriest"]
var finalTitle = ["Third of his Kind", "Devourer of Dodos", "Destroyer of the Free", "Annihilator of Freedoms", "First to Ascend", "Built to Kill"]

#The Accursed William The Dismantler, Third of his Kind
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$BossNameLbl.text = generateName()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func setHealth(fraction):
	$HealthBar.value = fraction*100

func generateName():
	var t1 = titles[randi()%len(titles)]
	var n = names[randi()%len(names)]
	var t2 = secondTitles[randi()%len(secondTitles)]
	var t3 = finalTitle[randi()%len(finalTitle)]

	return "The " + t1 + " " + n + " The " + t2 + ", " + t3
