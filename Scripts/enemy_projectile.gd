extends CharacterBody2D

func _physics_process(delta: float) -> void:
	move_and_slide()
	position += velocity * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		body.take_damage(20)
		queue_free()
