extends NodeState

@export var player: Player
@export var animation_player: AnimationPlayer
@export var body: AnimatedSprite2D
@export var hair: AnimatedSprite2D
@export var tools: AnimatedSprite2D

@export var hit_component_collision_shape: CollisionShape2D

func _ready() -> void:
	hit_component_collision_shape.disabled = true
	hit_component_collision_shape.position = Vector2(0,0)

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animation_player.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		flip_sprite(false)
		animation_player.play("axe")
		hit_component_collision_shape.position = Vector2(0, -18)
	elif player.player_direction == Vector2.RIGHT:
		flip_sprite(false)
		animation_player.play("axe")
		hit_component_collision_shape.position = Vector2(9, 0)
	elif player.player_direction == Vector2.DOWN:
		flip_sprite(false)
		animation_player.play("axe")
		hit_component_collision_shape.position = Vector2(0, 3)
	elif player.player_direction == Vector2.LEFT:
		flip_sprite(true)
		animation_player.play("axe")
		hit_component_collision_shape.position = Vector2(-9, 0)
	else:
		flip_sprite(false)
		animation_player.play("axe")
		hit_component_collision_shape.position = Vector2(0, 3)

	hit_component_collision_shape.disabled = false
	
func _on_exit() -> void:
	animation_player.stop()
	hit_component_collision_shape.disabled = true

func flip_sprite(flip: bool) -> void:
	body.flip_h = flip
	hair.flip_h = flip
	tools.flip_h = flip
	
