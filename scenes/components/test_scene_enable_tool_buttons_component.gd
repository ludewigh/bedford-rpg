extends Node

func _ready() -> void:
	call_deferred("enable_tool_buttons")


func enable_tool_buttons() -> void:
	ToolManager.enable_tool_button(DataTypes.Tools.TillGround)
	ToolManager.enable_tool_button(DataTypes.Tools.WaterCrops)
	ToolManager.enable_tool_button(DataTypes.Tools.Pickaxe)
	ToolManager.enable_tool_button(DataTypes.Tools.Hammer)
	ToolManager.enable_tool_button(DataTypes.Tools.Rod)
	ToolManager.enable_tool_button(DataTypes.Tools.AxeWood)
