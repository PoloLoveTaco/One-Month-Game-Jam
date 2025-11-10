extends CharacterBody2D

@export var speed:float = 400.0
@export var max_health: float = 100.0
var health: float

@export var weapon_scenes: Array[PackedScene] = [null, null, null, null]
var weapons: Array = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	health = max_health
	
	for scene in weapon_scenes:
		if scene == null:
			continue
		var weapon = scene.instantiate()
		weapon.owner = self
		add_child(weapon)
		weapons.append(weapon)

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity = input_direction * speed
	
	if velocity != Vector2(0, 0):
		animated_sprite_2d.play("walk")
	else:
		animated_sprite_2d.play("default")

func _physics_process(_delta):
	get_input()
	move_and_slide()

func take_damage(amount: int) -> void:
	health -= amount
	if health <= 0:
		queue_free()
