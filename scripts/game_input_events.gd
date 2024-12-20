class_name GameInputEvents

static var direction: Vector2

static func movement_input() -> Vector2:
	if Input.is_action_pressed("walk_left"):
		direction = Vector2.LEFT
	elif Input.is_action_pressed("walk_right"):
		direction = Vector2.RIGHT
	elif Input.is_action_pressed("walk_up"):
		direction = Vector2.UP
	elif Input.is_action_pressed("walk_down"):
		direction = Vector2.DOWN
	else:
		direction = Vector2.ZERO
		
	return direction
	
static func is_movement_input() -> bool:
	if direction == Vector2.ZERO:
		return false
	else:
		return true

static func use_tool() -> bool:
	var use_tool_value: bool = Input.is_action_just_pressed("hit")
	return use_tool_value


static func get_cell_under_mouse(tile_map_layer: TileMapLayer, player: Player) -> Array:
	var mouse_position: Vector2 = tile_map_layer.get_local_mouse_position()
	var cell_position: Vector2i = tile_map_layer.local_to_map(mouse_position)
	var cell_source_id: int = tile_map_layer.get_cell_source_id(cell_position)
	var local_cell_position : Vector2  = tile_map_layer.map_to_local(cell_position)
	var tile_data: TileData = tile_map_layer.get_cell_tile_data(cell_position)
	var distance: float  = player.global_position.distance_to(local_cell_position)
	
	return [distance, cell_source_id, cell_position]
