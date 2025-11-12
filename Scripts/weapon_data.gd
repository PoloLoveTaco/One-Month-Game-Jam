extends UpgradeData
class_name WeaponData

enum WeaponType {RANGE, MELEE, ELEMENTAL}

@export var weapon_scene: PackedScene
@export var base_damage: float = 10.0
@export var cooldown: float = 0.5
@export var attack_range: float = 200.0
@export var knockback: float = 100.0
@export var projectile_speed: float = 400
@export var types: Array[WeaponType]
