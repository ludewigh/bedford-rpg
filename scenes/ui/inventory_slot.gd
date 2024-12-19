extends Control

# Scene-Tree Node references
@onready var icon = $MarginContainer/ItemContainer/ItemIcon
@onready var quantity_label = $CountContainer/MarginContainer2/ItemQuantity
@onready var details_panel = $DetailsPanel
@onready var item_name = $DetailsPanel/ItemName
@onready var item_type = $DetailsPanel/ItemType
@onready var item_effect = $DetailsPanel/ItemEffect
@onready var usage_panel = $UsagePanel

@onready var count_container: PanelContainer = $CountContainer
@onready var item_container: PanelContainer = $MarginContainer/ItemContainer

# Slot item
var item = null

# Show usage panel for player to use/remove item
func _on_item_button_pressed():
	if item != null:
		usage_panel.visible = !usage_panel.visible

# Show item details on hover enter
func _on_item_button_mouse_entered():
	if item != null:
		usage_panel.visible = false
		details_panel.visible = true

# Hide item details on hover exit
func _on_item_button_mouse_exited():
	details_panel.visible = false

# Default empty slot
func set_empty():
	icon.texture = null
	quantity_label.text = ""
	count_container.visible = false
	var style = theme.get_stylebox("disable","InventoryItemPanel")
	item_container.add_theme_stylebox_override("panel", style)
# Set slot item with its values from the dictionary
func set_item(new_item):
	item = new_item
	icon.texture = item["texture"] 
	quantity_label.text = str(item["quantity"])
	item_name.text = str(item["name"])
	item_type.text = str(item["type"])
	if item["effect"] != "":
		item_effect.text = str("+ ", item["effect"])
	else: 
		item_effect.text = ""

# Remove item from inventory and drop it back into the world        		
func _on_drop_button_pressed():
	if item != null:
		var drop_position = InventoryManager.player_node.global_position
		var drop_offset = Vector2(0, 50)
		drop_offset = drop_offset.rotated(InventoryManager.player_node.rotation)
		InventoryManager.drop_item(item, drop_position + drop_offset)
		InventoryManager.remove_item(item["type"], item["effect"])
		usage_panel.visible = false

# Remove item from inventory, use it, and apply its effect (if possible)		
func _on_use_button_pressed():
	usage_panel.visible = false
	if item != null and item["effect"] != "":
		if InventoryManager.player_node:
			InventoryManager.player_node.apply_item_effect(item)
			InventoryManager.remove_item(item["type"], item["effect"])
		else:
			print("Player could not be found")
