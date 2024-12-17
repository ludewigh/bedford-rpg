extends NodeState

@export var player: Player
@export var animation_player: AnimationPlayer
@export var body: AnimatedSprite2D
@export var hair: AnimatedSprite2D
@export var tools: AnimatedSprite2D
@export var speed: int = 50

func _on_process(_delta : float) -> void:
	pass

func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	if direction == Vector2.UP:
		flip_sprite(false)
		animation_player.play("walk_base")
	elif direction == Vector2.RIGHT:
		flip_sprite(false)
		animation_player.play("walk_base")
	elif direction == Vector2.DOWN:
		flip_sprite(false)
		animation_player.play("walk_base")
	elif direction == Vector2.LEFT:
		flip_sprite(true)
		animation_player.play("walk_base")
	else:
		flip_sprite(false)
		animation_player.play("walk_base")
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
	
	player.velocity = direction * speed
	player.move_and_slide()
	
func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass

#
#func _on_exit() -> void:
	#animated_sprite_2d.stop()

func flip_sprite(flip: bool) -> void:
	body.flip_h = flip
	hair.flip_h = flip
	tools.flip_h = flip
	
