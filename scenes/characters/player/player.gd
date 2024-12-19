class_name Player
extends CharacterBody2D

@onready var hit_component: HitComponent = $HitComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

signal inventory_visible

var player_direction: Vector2

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	InventoryManager.set_player_reference(self)
	

func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool
