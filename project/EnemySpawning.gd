extends Node2D

@onready var Enemy = preload("res://Enemy.tscn")
@onready var Ghost = preload("res://Ghost.tscn")
@onready var Slime = preload("res://Slime.tscn")

var spawn_position = 0

func _on_timer_timeout():
	spawn_enemy()
	
	
func spawn_enemy():
	var waits = [7, 3.5, 2, 1]
	$EnemySpawn.wait_time = waits[Global.completed]
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
	
	var positions = [Vector2(87, 1251), Vector2(1293, 2158), Vector2(3179, 2780), Vector2(4675, 2339), Vector2(4037, 427)]
	enemy_instance.global_position = positions[spawn_position]
	spawn_position += 1
	if spawn_position == positions.size():
		spawn_position = 0
	
	enemy_instance.health = Global.enemy_stats[sel_enemy]["Health"]
	enemy_instance.speed = Global.enemy_stats[sel_enemy]["Speed"]
