extends CharacterBody2D

@export var speed:float = 400

@export var max_health: float = 100
var health: float

@export var max_coin: int = 999999
@export var coin: int = 0

@export var weapon_scenes: Array[PackedScene] = [null, null, null, null]
var weapons: Array = []

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var coin_count: Label = $CanvasLayer/CoinCount
@onready var wave_count: Label = $CanvasLayer/WaveCount
@onready var timer_label: Label = $CanvasLayer/TimerLabel

func _ready() -> void:
	health = max_health
	
	health_bar.max_value = max_health
	health_bar.value = health
	update_life_bar_color()
	
	update_coin_label()
	
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

#region health management

func take_damage(amount: float):
	health -= amount
	health_bar.value = health
	update_life_bar_color()
	if health <= 0:
		queue_free()

func update_life_bar_color() -> void:
	var health_pourcent := health / max_health

	var fill := StyleBoxFlat.new()
	if health_pourcent > 0.50:
		fill.bg_color = Color(0.0, 0.941, 0.631)
	elif health_pourcent > 0.15:
		fill.bg_color = Color(1.0, 0.888, 0.317, 1.0)
	else:
		fill.bg_color = Color(1.0, 0.496, 0.451)
	health_bar.add_theme_stylebox_override("fill", fill)

#endregion

#region coin management

func collect_coin():
	if coin < max_coin:
		coin = coin + 1
		update_coin_label()

func update_coin_label():
	coin_count.text = "Coin: " + str(coin)

#endregion
