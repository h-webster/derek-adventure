extends CharacterBody2D

var speed = 200
var accel = 10

var health = 3

@onready var nav = $NavigationAgent2D
@onready var target = get_node("../../Char")
var point = Vector3()

func _physics_process(delta):
	var direction = Vector3()
	
	nav.target_position = target.global_position
	direction = nav.get_next_path_position() - global_position
	direction = direction.normalized()
	velocity = velocity.lerp(direction * speed, accel * delta)
	
	move_and_slide()

