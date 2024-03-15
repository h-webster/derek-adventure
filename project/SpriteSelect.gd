extends Sprite2D

var costumes = 9
# Called when the node enters the scene tree for the first time.
func _ready():
	update()

func update():
	texture = load("res://Images/Player/base-" + str(Global.sel_hair) + "-" + str(Global.sel_costume) + "-pixilart.png")
	


func _on_right_hair():
	if Global.sel_hair == 3:
		Global.sel_hair = 1
	else:
		Global.sel_hair += 1
	update()


func _on_left_hair():
	if Global.sel_hair == 1:
		Global.sel_hair = 3
	else:
		Global.sel_hair -= 1
	update()


func _on_right_costume():
	if Global.sel_costume == costumes:
		Global.sel_costume = 1
	else:
		Global.sel_costume += 1
	update()


func _on_left_costume():
	if Global.sel_costume == 1:
		Global.sel_costume = costumes
	else:
		Global.sel_costume -= 1
	update()
