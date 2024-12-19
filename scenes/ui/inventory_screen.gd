extends Control

@export var grid_container: GridContainer

func _ready():
	# Connect function to signal to update inventory UI
	InventoryManager.inventory_updated.connect(_on_inventory_updated)
	
	_on_inventory_updated()

func _input(event):
	if event.is_action_pressed("ui_inventory"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused


# Update inventory UI
func _on_inventory_updated():
	# Clear existing slots
	clear_grid_container()
	# Add slots for each inventory position
	for item in InventoryManager.inventory:
		var slot = InventoryManager.inventory_slot_scene.instantiate()
		
		grid_container.add_child(slot)
		if item != null:
			slot.set_item(item)
		else:
			slot.set_empty() 
				
# Clear inventory UI grid	
func clear_grid_container():
	pass
	while grid_container.get_child_count() > 0:
		var child = grid_container.get_child(0)
		grid_container.remove_child(child)
		child.queue_free()
