extends Node

@export var item_texture: Texture

func _ready() -> void:
	call_deferred("enable_tool_buttons")
	call_deferred("add_items")


func enable_tool_buttons() -> void:
	ToolManager.enable_tool_button(DataTypes.Tools.TillGround)
	ToolManager.enable_tool_button(DataTypes.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataTypes.Tools.Pickaxe)
	ToolManager.enable_tool_button(DataTypes.Tools.Hammer)
	ToolManager.enable_tool_button(DataTypes.Tools.Rod)
	ToolManager.enable_tool_button(DataTypes.Tools.AxeWood)


func add_items() -> void:
	var scene_path: String = "res://scenes/components/inventory_item.tscn"	
	var item = {
		"quantity": 99,
		"type": "item_type",
		"name": "item_name",
		"effect": "item_effect",
		"texture": item_texture,
		"scene_path": scene_path
	}
	var item2 = {
		"quantity": 1,
		"type": "item_type2",
		"name": "item_name2",
		"effect": "item_effect2",
		"texture": item_texture,
		"scene_path": scene_path
	}
	if InventoryManager.player_node:
		InventoryManager.add_item(item)
		InventoryManager.add_item(item2)
		self.queue_free()
