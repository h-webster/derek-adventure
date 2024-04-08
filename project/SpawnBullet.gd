extends Node2D

@onready var Bullet = preload("res://bullet.tscn")

func add_bullet():
	if Global.sel_gun != 1:
		var bullet_instance = Bullet.instantiate()
		add_child(bullet_instance)
		bullet_instance.DMG = Global.gun_stats[Global.guns[Global.sel_gun]]["DMG"]
		print(Global.bullets.name)		
		bullet_instance.global_position = Global.gun.global_position
		bullet_instance.rotation = Global.gun.rotation
		bullet_instance.scale = Vector2(3,3)
		if Global.sel_gun == 2:
			bullet_instance.get_node("Sprite2D").texture = load("res://Images/Guns/rocket.png")
			bullet_instance.type = "Rocket"
	else:
		shotgun()
	
func add_rocket(pos):
	var explosion = load("res://explosion.tscn")
	var boom = explosion.instantiate()
	$Explosion.play()
	add_child(boom)
	boom.global_position = pos
	boom.emitting = true

func shotgun():
	var extra_bullets = 5
	var bullets = []
	var rotations = 0.5
	for i in range(extra_bullets):
		var bullet_instance1 = Bullet.instantiate()
		add_child(bullet_instance1)
		bullets.append(bullet_instance1)
	var a = 0
	for bullet in bullets:
		bullet.DMG = 1
		bullet.global_position = Global.gun.global_position
		bullet.scale = Vector2(3,3)
		bullet.rotation = Global.gun.rotation + (0.5 - (0.25 * a))
		a += 1
# Called every frame. 'delta' is the elapsed time since the previous frame.



