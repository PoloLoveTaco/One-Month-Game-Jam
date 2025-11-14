extends Node
class_name PlayerStats

var base_stats = {
	"damage": 1.0,
	"max_hp": 100.0,
	"move_speed": 400.0,
	"regen": 0.0,
	"attack_speed": 1.0,
	"crit_chance": 0.0,
	"luck": 0.0
}

var items: Array[ItemData] = []

func add_item(item: ItemData):
	if items.count(item) >= item.max_stack:
		return
	items.append(item)
	recalc_stats()

func recalc_stats():
	var final_stats = base_stats.duplicate()
	
	for item in items:
		for mod in item.modifiers:
			match mod.stat:
				StatModifier.Stat.DAMAGE:
					final_stats["damage"] += mod.flat_bonus
					final_stats["damage"] *= 1.0 + mod.percent_bonus
				StatModifier.Stat.MAX_HP:
					final_stats["max_hp"] += mod.flat_bonus
					final_stats["max_hp"] *= 1.0 + mod.percent_bonus
				StatModifier.Stat.MOVE_SPEED:
					final_stats["move_speed"] += mod.flat_bonus
					final_stats["move_speed"] *= 1.0 + mod.percent_bonus
				StatModifier.Stat.REGEN:
					final_stats["regen"] += mod.flat_bonus
					final_stats["regen"] *= 1.0 + mod.percent_bonus
				StatModifier.Stat.ATTACK_SPEED:
					final_stats["attack_speed"] += mod.flat_bonus
					final_stats["attack_speed"] *= 1.0 + mod.percent_bonus
				StatModifier.Stat.CRIT_CHANCE:
					final_stats["crit_chance"] += mod.flat_bonus
					final_stats["crit_chance"] *= 1.0 + mod.percent_bonus
				StatModifier.Stat.LUCK:
					final_stats["luck"] += mod.flat_bonus
					final_stats["luck"] *= 1.0 + mod.percent_bonus
					
	base_stats = final_stats
