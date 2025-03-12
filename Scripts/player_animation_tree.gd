extends Node2D

@export var animation_tree : AnimationTree
@export var player : Player = get_owner()

var idle : bool
var last_facing_direction := Vector2(0,1)

func _ready() -> void:
	
	animation_tree.active = true

func _physics_process(_delta: float) -> void:
	
	idle = !player.velocity
	
	if !idle:
		last_facing_direction = player.velocity.normalized()
		
	animation_tree.set("parameters/AnimationNodeStateMachine/Walk/blend_position", last_facing_direction)
	animation_tree.set("parameters/AnimationNodeStateMachine/Idle/blend_position", last_facing_direction)
