extends Node

@onready var inventory_slot_scene = preload("res://scenes/ui/inventory_slot.tscn")

@export var berry : Texture

signal inventory_updated

var inventory = []
var player_node: Node = null

var spawnable_items = [
	{"type": "Consumable", "name": "Berry", "effect": "Health", "texture": preload("res://art/objects/icon31.png")},
	{"type": "Consumable", "name": "Water", "effect": "Stamina", "texture": preload("res://art/objects/icon9.png")},
	{"type": "Consumable", "name": "Mushroom", "effect": "Armor", "texture": preload("res://art/objects/icon32.png")},
	{"type": "Gift", "name": "Gemstone", "effect": "", "texture": preload("res://art/objects/icon21.png")},
]

func _ready():
	inventory.resize(30)
	
func add_item(item) -> bool:
	for i in range(inventory.size()):
		# Check if the item exists in the inventory and matches both type and effect
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["effect"] == item["effect"]:
			inventory[i]["quantity"] += item["quantity"]
			inventory_updated.emit()
			print("Item added", inventory)
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventory_updated.emit()
			print("Item added", inventory)
			return true
	return false

	
func remove_item(item_type, item_effect) -> bool:
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item_type and inventory[i]["effect"] == item_effect:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <= 0:
				inventory[i] = null
			inventory_updated.emit()
			return true
	return false

func adjust_drop_position(position):
	var radius = 100
	var nearby_items = get_tree().get_nodes_in_group("Items")
	for item in nearby_items:
		if item.global_position.distance_to(position) < radius:
			var random_offset = Vector2(randf_range(-radius, radius), randf_range(-radius, radius))
			position += random_offset
			break
	return position

func increase_inventory_size(extra_slots) -> void:
	inventory.resize(inventory.size() + extra_slots)
	inventory_updated.emit()
	
func set_player_reference(player) -> void:
	player_node = player

# Drops an item at a specified position, adjusting for nearby items
func drop_item(item_data, drop_position) -> void:
	var item_scene = load(item_data["scene_path"])
	var item_instance = item_scene.instantiate()
	item_instance.set_item_data(item_data)
	drop_position = adjust_drop_position(drop_position)
	item_instance.global_position = drop_position
	get_tree().current_scene.add_child(item_instance)
