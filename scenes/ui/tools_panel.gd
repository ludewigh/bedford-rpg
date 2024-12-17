extends PanelContainer

@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var tool_watering_can: Button = $MarginContainer/HBoxContainer/ToolWateringCan
@onready var tool_pickaxe: Button = $MarginContainer/HBoxContainer/ToolPickaxe
@onready var tool_rod: Button = $MarginContainer/HBoxContainer/ToolRod
@onready var tool_hammer: Button = $MarginContainer/HBoxContainer/ToolHammer

func _ready() -> void:
	ToolManager.enable_tool.connect(on_enable_tool_button)
	
	tool_tilling.disabled = true
	tool_tilling.focus_mode = Control.FOCUS_NONE
	
	tool_watering_can.disabled = true
	tool_watering_can.focus_mode = Control.FOCUS_NONE
	
	tool_pickaxe.disabled = true
	tool_pickaxe.focus_mode = Control.FOCUS_NONE
	
	tool_rod.disabled = true
	tool_rod.focus_mode = Control.FOCUS_NONE

	tool_hammer.disabled = true
	tool_hammer.focus_mode = Control.FOCUS_NONE
	
func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWood)

func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGround)

func _on_tool_watering_can_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)

func _on_tool_pickaxe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.Pickaxe)

func _on_tool_rod_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.Rod)

func _on_tool_hammer_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.Hammer)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("tool_wheel_down"):
		ToolManager.select_tool((ToolManager.selected_tool + 1) % DataTypes.Tools.size())
		if ToolManager.selected_tool == DataTypes.Tools.AxeWood:
			tool_axe.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.TillGround:
			tool_tilling.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.WaterCrops:
			tool_watering_can.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.Pickaxe:
			tool_pickaxe.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.Rod:
			tool_rod.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.Hammer:
			tool_hammer.grab_focus()
	elif event.is_action_pressed("tool_wheel_up"):
		ToolManager.select_tool((ToolManager.selected_tool - 1) % DataTypes.Tools.size())
		if ToolManager.selected_tool == DataTypes.Tools.AxeWood:
			tool_axe.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.TillGround:
			tool_tilling.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.WaterCrops:
			tool_watering_can.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.Pickaxe:
			tool_pickaxe.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.Rod:
			tool_rod.grab_focus()
		elif ToolManager.selected_tool == DataTypes.Tools.Hammer:
			tool_hammer.grab_focus()
	if event.is_action_pressed("release_tool"):
		ToolManager.select_tool(DataTypes.Tools.None)
		tool_axe.release_focus()
		tool_tilling.release_focus()
		tool_watering_can.release_focus()
		tool_pickaxe.release_focus()
		tool_rod.release_focus()
		tool_hammer.release_focus()

func on_enable_tool_button(tool: DataTypes.Tools) -> void:
	if tool == DataTypes.Tools.TillGround:
		tool_tilling.disabled = false
		tool_tilling.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.WaterCrops:
		tool_watering_can.disabled = false
		tool_watering_can.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.Pickaxe:
		tool_pickaxe.disabled = false
		tool_pickaxe.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.Rod:
		tool_rod.disabled = false
		tool_rod.focus_mode = Control.FOCUS_ALL
	elif tool == DataTypes.Tools.Hammer:
		tool_hammer.disabled = false
		tool_hammer.focus_mode = Control.FOCUS_ALL
