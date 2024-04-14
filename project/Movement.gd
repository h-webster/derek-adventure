extends CharacterBody2D


var SPEED = 600.0
const JUMP_VELOCITY = -400.0
@onready var item_sound = $ItemPickup
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var dialouge
var mission
func _ready():
	Global.gun = $Gun
	if get_tree().get_current_scene().get_name() == "Outside":
		if Global.last_enter != Vector2(0,0):
			global_position = Global.last_enter
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
	
	if Global.quests[Global.quest] == "person":
		if Global.person_quest == "":
			if Global.completed >= 3:
				mission.text = "Mission: \n" + "Return back home"
			else:
				mission.text = "Mission: \n" + "People Helped: " + str(Global.completed) + "/3"
		else:
			mission.text = "Mission: \n" + Global.item_quests[Global.person_quest][0] + str(Global.items) + "/" + str(Global.item_quests[Global.person_quest][1])
			if Global.items == Global.item_quests[Global.person_quest][1]:
				mission.text = "Mission: \n" + Global.item_quests[Global.person_quest][3] 
				#Global.items = 0
				#Global.person_quest = ""
				#Global.completed += 1
	else:
		mission.text = "Mission: \n" + Global.quests[Global.quest]
		
	

func display_menu():
	var area = $Collisions
	var display 
	if get_tree().get_current_scene().get_name() == "Room":
		display = get_node("../UI/display")
	else:
		display = $UI/display
	
	var collisions = area.get_overlapping_bodies()
	var areas = area.get_overlapping_areas()
	var can_interact = ["Door", "Grandma", "House", "Jamal", "JamalHouse", "JeffHouse", "Jeff", "Joe", "JoeHouse", "Instruction"]
	var can_interact_area
	if Global.person_quest != "":
		can_interact_area = Global.item_quests[Global.person_quest][2]
	var hit = false
	
	for collision in collisions:
		if collision.name in can_interact:
			hit = true
			break
	for collision in areas:
		if Global.person_quest != "":
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
		print(collision.name)
		if collision.name == "Door" and Global.quest == 1:
			Global.quest = 2
			get_tree().change_scene_to_file("res://Outside.tscn")
		elif collision.name == "House" and Global.completed < 3:
			dialouge.show_dialouge("none", ["I need to help 3 people"])
		elif collision.name == "JamalHouse" and (Global.person_quest == ""):
			Global.last_enter = global_position
			get_tree().change_scene_to_file("res://JamalRoom.tscn")
		elif Global.person_quest != "" and (collision.name == "JamalHouse" or collision.name == "Jamal"):
			if Global.item_quests[Global.person_quest][1] == Global.items:
				if collision.name == "JamalHouse" and not "Jamal" in Global.completed_people:
					Global.last_enter = global_position
					get_tree().change_scene_to_file("res://JamalRoom.tscn")
				elif collision.name == "Jamal" and Global.person_quest == "thirst":
					dialouge.show_dialouge("doneJamal", ["Jamal: THANK YOU DEREK!", "Jamal: *Drinks water"])
			elif collision.name == "Jamal" and not "Jamal" in Global.completed_people and Global.person_quest == "thirst":
				dialouge.show_dialouge("none", ["Jamal: Help me Derek!!", "Jamal: I'm very thirsty and\nmy water is unclean", "Jamal: Please get me an apple, filter\n and a water bottle"])
		elif collision.name == "Jamal" and Global.person_quest == "" and not "Jamal" in Global.completed_people:
			dialouge.show_dialouge("jamal", ["Jamal: Help me Derek!!", "Jamal: I'm very thirsty and\nmy water is unclean", "Jamal: Please get me an apple, filter\n and a water bottle"])
		elif collision.name == "JeffHouse":
			Global.last_enter = global_position
			get_tree().change_scene_to_file("res://JeffRoom.tscn")
		elif collision.name == "JoeHouse":
			Global.last_enter = global_position
			get_tree().change_scene_to_file("res://JoeRoom.tscn")
		elif collision.name == "House" and Global.completed >= 2 and Global.person_quest == "":
			get_tree().change_scene_to_file("res://Win.tscn")
		elif collision.name == "Door" and Global.quest == 2:
			print("what")
			get_tree().change_scene_to_file("res://Outside.tscn")
		elif collision.name == "Door" and Global.quest == 3:
			dialouge.show_dialouge("none", ["I don't need to go outside"])
		elif collision.name == "Jeff" and not "Jeff" in Global.completed_people:
			if Global.person_quest == "":
				dialouge.show_dialouge("jeff", ["Jeff: Derek I'm hungry and dirty.", "Jeff: Please help me by getting \nthese items", "Jeff: A shirt, pants, banana and \nmeat"])
			elif Global.item_quests[Global.person_quest][1] == Global.items and Global.person_quest == "hungry":
				dialouge.show_dialouge("doneJeff", ["Jeff: Oh Mr.Derek thank youu"])
			elif Global.item_quests[Global.person_quest][1] != Global.items and Global.person_quest == "hungry":
				dialouge.show_dialouge("none", ["Jeff: Please get me my items..."])
		elif collision.name == "Joe" and not "Joe" in Global.completed_people:
			if Global.person_quest == "":
				dialouge.show_dialouge("joe", ["Joe: Derek I want education", "Joe: But, I don't have any \nmoney", "Joe: I need a book, paper, pencil \nand lamp"])
			elif Global.item_quests[Global.person_quest][1] == Global.items and Global.person_quest == "education":
				dialouge.show_dialouge("doneJoe", ["Joe: Thanks I can now learn anything!"])
			elif Global.item_quests[Global.person_quest][1] != Global.items and Global.person_quest == "education":
				dialouge.show_dialouge("none", ["Joe: Be careful."])
		elif collision.name == "Instruction":
			dialouge.show_dialouge("none", ["Welcome to derek's adventure!", "Here is how to play...", "In this game you have to\nhelp people by", "getting specific items for \nthem.", "There are also enemies trying\nto kill you!", "You have guns to \nshoot the enemies.", "You get more guns when \nyou help people", "To switch guns press \n1, 2 or 3"])
	var items = ["none"]
	if Global.person_quest != "":
		items = Global.item_quests[Global.person_quest][2]
	for collision in areas:
		if items[0] != "none":
			if collision.name in items:
				Global.items_collected.append(collision.name)
				collision.get_parent().queue_free()
				item_sound.play()
				Global.items += 1

