extends Button
class_name ShopItem

@onready var item_icon := $Panel/Icon
@onready var item_name := $Panel/Name
@onready var item_desc := $Panel/Desc

@onready var cost_label := $Panel/Cost/PriceLabel


func set_item(u: UpgradeData):
	item_name.text = u.display_name
	item_desc.text = u.description
	item_icon.texture = u.icon
	cost_label.text = str(u.cost)
