extends Button


func _on_pressed():
	Global.quest = 0
	Global.items = 0
	get_tree().change_scene_to_file("res://source/Start.tscn")
