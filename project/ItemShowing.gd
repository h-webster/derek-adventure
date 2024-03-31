extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	for child in get_children():
		if Global.person_quest == "":
			child.visible = false
		else:
			if child.name in Global.item_quests[Global.person_quest][2] and not child.name in Global.items_collected:
				child.visible = true
			else:
				child.visible = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
