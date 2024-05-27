extends Resource

class_name Inventory

signal updated
signal use_item

@export var slots: Array[Inventory_Slot]

func insert(item: Inventory_Item):
	for slot in slots:
		if slot.item == item:
			if slot.amount >= slot.item.maxAmountPrStack:
				continue
			slot.amount += 1
			updated.emit()
			return
	
	for i in range(slots.size()):
		if !slots[i].item:
			slots[i].item = item
			slots[i].amount = 1
			updated.emit()
			return

func removeSlot(inventorySlot: Inventory_Slot):
	var index = slots.find(inventorySlot)
	if index < 0: return
	
	remove_at_index(index)
	
func remove_at_index(index: int) -> void:
	slots[index] = Inventory_Slot.new()
	updated.emit()

func insertSlot(index: int, inventorySlot: Inventory_Slot):
	slots[index] = inventorySlot
	updated.emit()

func get_selected_item_info(index: int):
	return slots[index].item

func use_item_at_index(index: int) -> void:
	if index < 0 || index >= slots.size() || !slots[index].item: return
	
	var slot = slots[index]
	use_item.emit(slot.item)
	
	if slot.amount > 1:
		slot.amount -= 1
		updated.emit()
		return
	
	var item = get_selected_item_info(index)
	if item:
		match item.item_type:
			'weapon':
				pass
			_:
				remove_at_index(index)

