extends Node2D

@onready var Enemy = preload("res://Enemy.tscn")
@onready var Ghost = preload("res://Ghost.tscn")
@onready var Slime = preload("res://Slime.tscn")



func _on_timer_timeout():
	spawn_enemy()
	
	
func spawn_enemy():
	var enemies = ["Slime","Slime","Slime","Enemy", "Enemy", "Ghost"]
	var sel_enemy = enemies[randi() % enemies.size()]
	
	var enemy_instance
	if sel_enemy == "Enemy":
		enemy_instance = Enemy.instantiate()
	elif sel_enemy == "Ghost":
		enemy_instance = Ghost.instantiate()
	elif sel_enemy == "Slime":
		enemy_instance = Slime.instantiate()
	add_child(enemy_instance)
	
	enemy_instance.global_position = Vector2(87, 1251)
	
	enemy_instance.health = Global.enemy_stats[sel_enemy]["Health"]
	enemy_instance.speed = Global.enemy_stats[sel_enemy]["Speed"]
