extends Node
class_name PlayerInventory

@export var max_weapons: int = 6
var weapons: Array[Node] = []

func add_weapon(data: WeaponData):
	if weapons.size() >= max_weapons:
		return
		
	var weapon_instance = data.weapon_scene.instantiate()
	weapon_instance.data = data
	add_child(weapon_instance)
	weapons.append(weapon_instance)
