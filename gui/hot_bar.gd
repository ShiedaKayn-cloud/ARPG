extends Panel

@onready var inventory: Inventory = preload("res://inventory/playerInventory.tres")
@onready var slots: Array = $Container.get_children()
@onready var selector: Sprite2D = $Selector

var currently_selected: int = 0

func _ready():
	update()
	inventory.updated.connect(update)

func update() -> void:
	for i in range(slots.size()):
		var inventorySlot: Inventory_Slot = inventory.slots[i]
		slots[i].update_to_slot(inventorySlot)

func move_selector()-> void:
	currently_selected = (currently_selected + 1) % slots.size()
	selector.global_position = slots[currently_selected].global_position

func _unhandled_input(event) -> void:
	if event.is_action_pressed("use_item"):
		inventory.use_item_at_index(currently_selected)
	if event.is_action_pressed("attack"):
		inventory.use_item_at_index(currently_selected)
	if event.is_action_pressed("move_selector"):
		move_selector()
