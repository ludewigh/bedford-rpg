class_name FieldCursorComponent
extends Node

@export var grass_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var tilled_terrain: int = 3
@export var watered_terrain: int = 4

var player: Player

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_dirt"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			var results = GameInputEvents.get_cell_under_mouse(grass_tilemap_layer, player)
			remove_tilled_soil_cell(results[0], results[1], results[2])
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGround:
			var results = GameInputEvents.get_cell_under_mouse(grass_tilemap_layer, player)
			add_tilled_soil_cell(results[0], results[1], results[2])
		elif ToolManager.selected_tool == DataTypes.Tools.WaterCrops:
			var results = GameInputEvents.get_cell_under_mouse(tilled_soil_tilemap_layer, player)
			add_watered_cell(results[0], results[1], results[2])
			

func add_tilled_soil_cell(distance: float, cell_source_id: int, cell_position: Vector2i) -> void:
	if distance < 20.0 && cell_source_id != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, tilled_terrain, true)

func add_watered_cell(distance: float, cell_source_id: int, cell_position: Vector2i) -> void:
	if distance < 20.0 && cell_source_id != -1:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, watered_terrain, true)
		
func remove_tilled_soil_cell(distance: float, cell_source_id: int, cell_position: Vector2i) -> void:
	if distance < 20.0:
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], 0, -1, true)
