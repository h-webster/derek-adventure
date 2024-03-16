extends CharacterBody2D


var SPEED = 600.0
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	$Sprite2D.texture = load("res://Images/Player/base-" + str(Global.sel_hair) + "-" + str(Global.sel_costume) + "-pixilart.png")
	

func _physics_process(delta):
	if SPEED == 600.0 and get_tree().current_scene.name == "Outside":
		SPEED = 600
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction_x = Input.get_axis("ui_left", "ui_right")
	if direction_x:
		velocity.x = direction_x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	var direction_y = Input.get_axis("ui_up", "ui_down")
	if direction_y:
		velocity.y = direction_y * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)
	move_and_slide()


func _on_door_collision_body_entered(body):
	get_tree().change_scene_to_file("res://Outside.tscn")
