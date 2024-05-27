extends Area2D

@export var itemRes: Inventory_Item

func collect(inventory: Inventory):
	inventory.insert(itemRes)
	queue_free()
