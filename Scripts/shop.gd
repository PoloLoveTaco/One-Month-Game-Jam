extends Control
class_name Shop

@export var possible_upgrades: Array[UpgradeData]
@export var choices_per_round: int = 5

var current_choices: Array[UpgradeData] = []

@onready var coins_label := $Panel/Header/Gold/GoldLabel
@onready var upgrades_grid := $Panel/GridContainer


@onready var shop_item_scene := preload("res://Scenes/shop_item.tscn")

var player : Player

func _ready() -> void:
	get_tree().paused = true
	player = get_tree().get_nodes_in_group("player")[0]
	coins_label.text = str(player.coins)
	
	roll_shop(1, player.player_stat.base_stats["luck"])

func roll_shop(wave: int, luck: float):
	
	var pool = possible_upgrades.filter(
		func(u: UpgradeData) -> bool:
			return can_show_upgrade(u, wave)
	)
	
	current_choices.clear()
	
	for i in range(choices_per_round):
		var choice = pick_random_upgrade(pool, luck)
		current_choices.append(choice)

	update_ui()
	
func can_show_upgrade(u: UpgradeData, wave: int):
	if u is WeaponData and player.inventory.weapons.size() >= player.inventory.max_weapons:
		return false
		
	return true

func pick_random_upgrade(pool: Array[UpgradeData], luck: float):
	if pool.is_empty():
		return null
		
	var weights = []
	for u in pool:
		var base_weight = 1.0 / u.rarity
		base_weight *= 1.0 + (luck * 0.05 * (u.rarity - 1))
		weights.append(base_weight)
	
	var total_weight = weights.reduce(func(a, b): return a + b)
	var r = randf() * total_weight
	var sum = 0.0
	
	for i in range(pool.size()):
		sum += weights[i]
		if r <= sum:
			return pool[i]
			
	return pool.back()

func update_ui():
	$Panel/GridContainer/ShopItem.set_item(current_choices[0])
	$Panel/GridContainer/ShopItem2.set_item(current_choices[1])
	$Panel/GridContainer/ShopItem3.set_item(current_choices[2])
	$Panel/GridContainer/ShopItem4.set_item(current_choices[3])
	$Panel/GridContainer/ShopItem5.set_item(current_choices[4])
	

func _on_reroll_button_pressed() -> void:
	roll_shop(1, player.player_stat.base_stats["luck"])
	update_ui()


func _on_next_wave_button_pressed() -> void:
	get_tree().paused = false
	queue_free()
