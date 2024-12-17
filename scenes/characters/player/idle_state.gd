extends NodeState

@export var player: Player
@export var animation_player: AnimationPlayer
@export var body: AnimatedSprite2D
@export var hair: AnimatedSprite2D
@export var tools: AnimatedSprite2D

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	if player.player_direction == Vector2.UP:
		flip_sprite(false)
		animation_player.play("idle_base")
	elif player.player_direction == Vector2.RIGHT:
		flip_sprite(true)
		animation_player.play("idle_base")
	elif player.player_direction == Vector2.DOWN:
		flip_sprite(false)
		animation_player.play("idle_base")
	elif player.player_direction == Vector2.LEFT:
		flip_sprite(true)
		animation_player.play("idle_base")
	else:
		animation_player.play("idle_base")

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")

	if player.current_tool == DataTypes.Tools.AxeWood && GameInputEvents.use_tool():
		transition.emit("Chopping")
	if player.current_tool == DataTypes.Tools.TillGround && GameInputEvents.use_tool():
		transition.emit("Digging")
	if player.current_tool == DataTypes.Tools.WaterCrops && GameInputEvents.use_tool():
		transition.emit("Watering")
	if player.current_tool == DataTypes.Tools.Attack && GameInputEvents.use_tool():
		transition.emit("Attacking")
	if player.current_tool == DataTypes.Tools.Hammer && GameInputEvents.use_tool():
		transition.emit("Hammering")
	if player.current_tool == DataTypes.Tools.WaterCrops && GameInputEvents.use_tool():
		transition.emit("Watering")
func _on_enter() -> void:
	pass

#
#func _on_exit() -> void:
	#animated_sprite_2d.stop()

func flip_sprite(flip: bool) -> void:
	body.flip_h = flip
	hair.flip_h = flip
	tools.flip_h = flip
	
