extends Control


@onready var hurt_sound = $hurt
var health = 3
func hit():
	var heart = get_node("Heart" + str(health))
	hurt_sound.play()
	heart.queue_free()
	health -= 1
	if health == 0:
		get_tree().change_scene_to_file("res://GameOver.tscn")


func enemy_hit(body):
	if body.name in Global.enemy_stats:
		hit()
