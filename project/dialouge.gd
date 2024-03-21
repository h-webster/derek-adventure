extends TextureRect

var dialouge_queue = []
var dialouge_name = ""

func ended():
	if dialouge_name == "Grandma":
		Global.quest = 1
	dialouge_name = ""

func _process(delta):
	if Input.is_action_just_pressed("Next"):
		dialouge_queue.remove_at(0)
		if dialouge_queue.size() == 0:
			visible = false
			ended()
		else:
			$Text.text = dialouge_queue[0]
func show_dialouge(dname, texts):
	dialouge_name = dname
	var text_display = $Text
	dialouge_queue = texts
	visible = true
	
	text_display.text = dialouge_queue[0]
	
	
