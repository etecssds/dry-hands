extends Control

@onready var gridContainer: GridContainer = $GridContainer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalInventory.inventoryUpdate.connect(inventory_updated)
	inventory_updated()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func inventory_updated():
	clear_grid_container()
	for item in GlobalInventory.inventory:
		var slot = GlobalInventory.inventorySlotScene.instantiate()
		gridContainer.add_child(slot)
		if item != null:
			slot.setItem(item)
		else:
			slot.setEmpty()
			
func clear_grid_container():
	while gridContainer.get_child_count() >0:
		var child = gridContainer.get_child(0)
		gridContainer.remove_child(child)
		child.queue_free()
