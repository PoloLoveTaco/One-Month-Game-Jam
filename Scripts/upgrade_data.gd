extends Resource
class_name UpgradeData

@export var id : StringName

@export var display_name: String
@export_multiline var description: String
@export var icon: Texture2D

@export var cost: int = 0
@export var rarity: int = 1   # 1=commun, 2=rare , 3=epic, 4=legendary
@export var max_stack: int = 100
