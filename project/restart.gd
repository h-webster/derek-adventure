extends Button


func _on_pressed():
	Global.quest = 1
	Global.items = 0
	Global.person_quest = ""
	Global.completed = 0
	Global.completed_people = []
	Global.last_enter = Vector2(0,0)
	get_tree().change_scene_to_file("res://source/Start.tscn")
