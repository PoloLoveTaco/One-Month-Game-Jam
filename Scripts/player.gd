extends CharacterBody2D
class_name Player

@export var speed:float = 400

@export var max_health: float = 100
var health: float

@export var max_coins: int = 999999
@export var coins: int = 0


@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var health_bar: ProgressBar = $CanvasLayer/HealthBar
@onready var coins_count: Label = $CanvasLayer/CoinCount
@onready var wave_count: Label = $CanvasLayer/WaveCount
@onready var timer_label: Label = $CanvasLayer/TimerLabel


@onready var player_stat = PlayerStats.new()
@onready var inventory = PlayerInventory.new()

@onready var shop_scene = preload("res://Scenes/Interfaces/shop.tscn")

func _ready() -> void:
	health = max_health
	
	health_bar.max_value = max_health
	health_bar.value = health
	update_life_bar_color()
	
	update_coin_label()
	
func _unhandled_input(event: InputEvent) -> void:
	
	if event.is_action_pressed("tmp"):
		var shop = shop_scene.instantiate()
		get_tree().current_scene.get_node("ShopLayer").add_child(shop)
	
	
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
	if coins < max_coins:
		coins = coins + 1
		update_coin_label()

func update_coin_label():
	coins_count.text = "Coins: " + str(coins)

#endregion

#region inventory
func buy_upgrade(upgrade: UpgradeData):
	if coins < upgrade.cost:
		return
	
	coins -= upgrade.cost
	
	if upgrade is WeaponData:
		inventory.add_weapon(upgrade as WeaponData)
	elif upgrade is ItemData:
		player_stat.add_item(upgrade as ItemData)
#endregion
