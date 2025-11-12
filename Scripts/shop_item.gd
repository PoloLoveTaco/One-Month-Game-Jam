extends Button
class_name ShopItem

const COLOR_COMMON     = Color(0.2, 0.8, 0.2, 0.2)
const COLOR_RARE       = Color(0.2, 0.4, 1.0, 0.2)
const COLOR_EPIC       = Color(0.7, 0.2, 0.9, 0.2)
const COLOR_LEGENDARY  = Color(1.0, 0.9, 0.2, 0.2)

@onready var item_icon := $Panel/Icon
@onready var item_name := $Panel/Name
@onready var item_desc := $Panel/Desc

@onready var cost_label := $Panel/Cost/PriceLabel

@onready var bk : ColorRect = $Panel/Background


func set_item(u: UpgradeData):
	item_name.text = u.display_name
	item_desc.text = u.description
	item_icon.texture = u.icon
	cost_label.text = str(u.cost)
	
	match u.rarity:
		1: bk.color = COLOR_COMMON
		2: bk.color = COLOR_RARE
		3: bk.color = COLOR_EPIC
		4: bk.color = COLOR_LEGENDARY
