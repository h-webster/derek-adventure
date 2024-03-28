extends CharacterBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * 700 * delta


func _on_hit(body):
	if body.is_in_group("enemies"):
		body.health -= 1
		if body.health <= 0:
			body.queue_free()
		else:
			pass
	queue_free()
