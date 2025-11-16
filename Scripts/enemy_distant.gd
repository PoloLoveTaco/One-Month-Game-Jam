extends Enemy

@export var BULLET: PackedScene
@export var bullet_speed := 300.0
@export var muzzle_offset := 16.0

func shoot_at_player() -> void:
	if player == null:
		return

	# Direction vers le joueur
	var dir: Vector2 = (player.global_position - global_position).normalized()

	# Position de spawn du projectile (un peu devant l’ennemi)
	var spawn_pos: Vector2 = global_position + dir * muzzle_offset

	_spawn_bullet(spawn_pos, dir)

func _spawn_bullet(spawn_pos: Vector2, dir: Vector2) -> void:
	var b := BULLET.instantiate()
	b.global_position = spawn_pos
	b.velocity = dir * bullet_speed
	b.look_at(spawn_pos + dir * 10.0)
	get_tree().current_scene.add_child(b)


func _on_shoot_timer_timeout() -> void:
	shoot_at_player()
