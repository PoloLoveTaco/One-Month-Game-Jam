extends RigidBody2D
class_name Enemy

@export_group("Stats")
@export var max_health: float = 40
@export var damage: float = 20
@export var attack_cooldown: float = 1.0
@export var move_speed: float = 80.0

@onready var attack_timer: Timer = $AttackTimer
var health: float
var player: Player = null
var can_attack: bool = true
var player_in_range := false


func _ready() -> void:
	health = max_health
	attack_timer.wait_time = attack_cooldown
	attack_timer.one_shot = true
	player = get_tree().get_first_node_in_group("player")


func _process(_delta: float) -> void:
	if player_in_range and can_attack:
		attack()


func _physics_process(delta):
	if player and not player_in_range:
		follow_player()


func follow_player() -> void:
	var direction = (player.global_position - global_position).normalized()
	linear_velocity = direction * move_speed


#region combat

func attack() -> void:
	if not player:
		return
	
	player.take_damage(damage)
	can_attack = false
	attack_timer.start()


func take_damage(amount: float) -> void:
	health -= amount
	if health <= 0:
		die()


func die() -> void:
	queue_free()

#endregion

#region signals

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_in_range = false


func _on_attack_timer_timeout() -> void:
	can_attack = true

#endregion
