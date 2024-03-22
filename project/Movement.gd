extends CharacterBody2D


var SPEED = 600.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dialouge
var mission
func _ready():
	$Sprite2D.texture = load("res://Images/Player/base-" + str(Global.sel_hair) + "-" + str(Global.sel_costume) + "-pixilart.png")
	if get_tree().get_current_scene().get_name() == "Room":
		dialouge = get_node("../UI/dialouge")
		mission = get_node("../UI/mission/Label")
	else:
		dialouge = $UI/dialouge
		mission = $UI/mission/Label
	

func _physics_process(delta):
	if dialouge.visible:
		return
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("Left", "Right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y = Input.get_axis("Up", "Down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()
	
	
	if display_menu() and Input.is_action_just_pressed("Interact"):
		interact()
	
	if Global.quests[Global.quest] != "item":
		mission.text = "Mission: \n" + Global.quests[Global.quest]
	else:
		mission.text = "Mission: \n" + "Collect items: " + str(Global.items) + "/6"
		if Global.items == 6:
			Global.quest = 3
	

func display_menu():
	var area = $Collisions
	var display 
	if get_tree().get_current_scene().get_name() == "Room":
		display = get_node("../UI/display")
	else:
		display = $UI/display
	
	var collisions = area.get_overlapping_bodies()
	var areas = area.get_overlapping_areas()
	var can_interact = ["Door", "Grandma", "House"]
	var can_interact_area = ["Grape", "Hotdog", "Carrot", "Water", "Pills", "Soda"]
	var hit = false
	
	for collision in collisions:
		if collision.name in can_interact:
			hit = true
			break
	for collision in areas:
		if collision.name in can_interact_area:
			hit = true
			break
			
	display.visible = hit
	
	if hit:
		display.global_position = Vector2(global_position.x - 120, global_position.y - 200)
	return hit

func interact():
	if dialouge.visible:
		return
	
	var area = $Collisions
	var collisions = area.get_overlapping_bodies()
	var areas = area.get_overlapping_areas()
	for collision in collisions:
		if collision.name == "Door" and Global.quest == 1:
			Global.quest = 2
			get_tree().change_scene_to_file("res://Outside.tscn")
		elif collision.name == "Door" and Global.quest == 0:
			dialouge.show_dialouge("none", ["I need to talk to my Grandma first"])
		elif collision.name == "Grandma" and Global.quest != 3:
			dialouge.show_dialouge("Grandma", ["Grandma: Derekkkkk!!!!", "Grandma: I'm very sick", "Grandma: Can you please grab \nstuff for me?", "Grandma: I need the following items", "Grandma: Grapes", "Grandma: A hot dog", "Grandma: A Carrot", "Grandma: Soda", "Grandma: Water", "Grandma: and some pills", "Grandma: Be careful Derek, it's \ndangerous out there"])
		elif collision.name == "House" and Global.quest != 3:
			dialouge.show_dialouge("none", ["Grab the items!!!"])
		elif collision.name == "House" and Global.quest == 3:
			get_tree().change_scene_to_file("res://Room.tscn")
		elif collision.name == "Grandma" and Global.quest == 3:
			dialouge.show_dialouge("Finish", ["Grandma: OH MY DEREKKK!!!", "Grandma: Thank you for all these items!"])
		elif collision.name == "Door" and Global.quest == 3:
			dialouge.show_dialouge("none", ["I don't need to go outside"])
	var items = ["Grape", "Hotdog", "Carrot", "Water", "Pills", "Soda"]
	for collision in areas:
		if collision.name in items:
			collision.get_parent().queue_free()
			Global.items += 1

