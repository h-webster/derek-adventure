extends CharacterBody2D

var DMG = 2
var type = "Bullet"
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if type == "Bullet":
		$Rocket.monitoring = false
	position += transform.x * 700 * delta


func _on_hit(body):
	if body.is_in_group("enemies"):
		if type == "Bullet":
			body.health -= DMG
			if body.health <= 0:
				body.queue_free()
			else:
				pass
			queue_free()
		elif type == "Rocket":
			print("rocket hit")
			Global.bullets.add_rocket(global_position)
			$Rocket.monitoring = true
	else:
		queue_free()


func _on_rocket_hit(body):
	if body.is_in_group("enemies"):
		body.health -= 10
		if body.health <= 0:
			body.queue_free()
		else:
			pass
	queue_free()
