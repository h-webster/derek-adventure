extends TextureRect

var selected = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("Inv1"):
		selected = 0
	elif Input.is_action_just_pressed("Inv2"):
		selected = 1
	elif Input.is_action_just_pressed("Inv3"):
		selected = 2
	if selected > Global.completed:
		selected -= 1
	if selected < 0:
		selected = 0
		
	Global.sel_gun = selected
	var positions = [130, 267, 414]
	$Selected.position = Vector2(positions[selected], 231)
	
	for i in range(3):
		var slot = get_node(str(i))
		if Global.completed >= i:
			slot.visible = true
			slot.texture = load("res://Images/Guns/" + str(Global.guns[i]) + ".png")
		else:
			slot.visible = false
	
	
