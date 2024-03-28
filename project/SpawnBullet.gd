extends Node2D

@onready var Bullet = preload("res://bullet.tscn")

func add_bullet():
	var bullet_instance = Bullet.instantiate()
	add_child(bullet_instance)
	print(Global.bullets.name)		
	bullet_instance.global_position = Global.gun.global_position
	bullet_instance.rotation = Global.gun.rotation
	bullet_instance.scale = Vector2(3,3)
# Called every frame. 'delta' is the elapsed time since the previous frame.



