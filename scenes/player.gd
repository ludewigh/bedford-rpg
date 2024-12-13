extends CharacterBody2D

#@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hit_component: HitComponent = $HitComponent

@onready var body: AnimatedSprite2D = $Body
@onready var hair: AnimatedSprite2D = $Hair
@onready var tools: AnimatedSprite2D = $Tools

@export var current_tool: DataTypes.Tools = DataTypes.Tools.None

var current_direction: String = "none"
const speed: int = 100

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	
func on_tool_selected(tool: DataTypes.Tools) -> void:
	current_tool = tool
	hit_component.current_tool = tool


func _physics_process(delta: float) -> void:
	player_movement(delta)
	
func player_movement(delta: float) -> void:
	if Input.is_action_pressed("ui_right"):
		current_direction = "right"
		play_animation(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_left"):
		current_direction = "left"
		play_animation(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("ui_down"):
		current_direction = "down"
		play_animation(1)
		velocity.x = 0
		velocity.y = speed
	elif Input.is_action_pressed("ui_up"):
		current_direction = "up"
		play_animation(1)
		velocity.x = 0
		velocity.y = -speed
	else:
		play_animation(0)
		velocity.x = 0
		velocity.y = 0
		
	move_and_slide()

func play_animation(movement: int) -> void:
	if current_direction == "right":
		flip_sprite(false)
		if movement == 1:
			animation_player.play("walk_base")
		elif movement == 0:
			animation_player.play("idle_base")
	elif current_direction == "left":
		flip_sprite(true)
		if movement == 1:
			animation_player.play("walk_base")
		elif movement == 0:
			animation_player.play("idle_base")
	elif current_direction == "up":
		flip_sprite(false)
		if movement == 1:
			animation_player.play("walk_base")
		elif movement == 0:
			animation_player.play("idle_base")
	elif current_direction == "down":
		flip_sprite(false)
		if movement == 1:
			animation_player.play("walk_base")
		elif movement == 0:
			animation_player.play("idle_base")

func flip_sprite(flip: bool) -> void:
	body.flip_h = flip
	hair.flip_h = flip
	tools.flip_h = flip
	
