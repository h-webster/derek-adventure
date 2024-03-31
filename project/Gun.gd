extends CharacterBody2D

@onready var Bullet = preload("res://bullet.tscn")
var outside
# Called when the node enters the scene tree for the first time.
func _ready():
	var outside = get_node("../../Bullets")
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(0,0)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	position = transform.x * 17

	if Input.is_action_just_pressed("Shoot"):
		$Shoot.play()
		Global.bullets.add_bullet()

