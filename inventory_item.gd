extends Resource

class_name Inventory_Item

@export var item_name: String
@export var item_type: String
@export var texture: Texture2D
@export var maxAmountPrStack: int

func use(player: Player) -> void:
	player.equip_item = self
