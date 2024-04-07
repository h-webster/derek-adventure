extends CharacterBody2D

@onready var Bullet = preload("res://bullet.tscn")
var outside
var can_shoot = true
# Called when the node enters the scene tree for the first time.
func _ready():
	var outside = get_node("../../Bullets")
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = Vector2(0,0)
	var mouse_pos = get_global_mouse_position()
	look_at(mouse_pos)
	position = transform.x * 17
	var SelGun = Global.guns[Global.sel_gun]
	$Sprite2D.texture = load("res://Images/Guns/" + str(SelGun) + ".png")
	$ShootEffect.lifetime = Global.gun_stats[SelGun]["Speed"]
	$Reload.wait_time = Global.gun_stats[SelGun]["Speed"]
	if Input.is_action_just_pressed("Shoot") and can_shoot:
		$Shoot.play()
		$ShootEffect.emitting = true
		Global.bullets.add_bullet()
		can_shoot = false
		$Reload.start()



func _on_reload_timeout():
	can_shoot = true
