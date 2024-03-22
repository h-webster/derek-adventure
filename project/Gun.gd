extends CharacterBody2D

@onready var Bullet = preload("res://bullet.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(0,0)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	position = transform.x * 17
	'''
	if Input.is_action_just_pressed("Shoot"):
		bullet_instance = Bullet.instantiate()
	add_child()
	'''
