extends Button
class_name ShopItem

const COLOR_COMMON     = Color(0.2, 0.8, 0.2, 1.0)
const COLOR_RARE       = Color(0.2, 0.4, 1.0, 1.0)
const COLOR_EPIC       = Color(0.698, 0.2, 0.902, 1.0)
const COLOR_LEGENDARY  = Color(1.0, 0.902, 0.2, 1.0)
const COLOR_BUY        = Color(0.248, 0.241, 0.259, 1.0)

@onready var item_icon := $Panel/Icon
@onready var item_name := $Panel/Name
@onready var item_desc := $Panel/Desc

@onready var gold_icon: TextureRect = $Panel/Cost/GoldIcon
@onready var cost_label := $Panel/Cost/PriceLabel

@onready var bk : ColorRect = $Panel/Background
@onready var is_buyable: bool = true


func set_item(u: UpgradeData):
	is_buyable = true
	item_name.text = u.display_name
	item_desc.text = u.description
	item_icon.texture = u.icon
	gold_icon.show()
	cost_label.text = str(u.cost)
	
	match u.rarity:
		1: bk.color = COLOR_COMMON
		2: bk.color = COLOR_RARE
		3: bk.color = COLOR_EPIC
		4: bk.color = COLOR_LEGENDARY

func buy_item():
	is_buyable = false
	
	item_name.text = "Already buy"
	item_desc.text = ""
	item_icon.texture = null
	cost_label.text = ""
	gold_icon.hide()
	bk.color = COLOR_BUY
