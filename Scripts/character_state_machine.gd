class_name CharacterStateMachine extends Node

@export var initial_state : State

@onready var character := get_parent()

var current_state : State
var states : Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.transitioned.connect(on_child_transitioned)
			child.character = character
		else:
			push_error('The child "' + child.name + '" is not a state for State Machine')
	
	if initial_state:
		initial_state.enter()
		current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.state_process(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.state_physics_process(delta)

func on_child_transitioned(state, new_state_name):
	if state != current_state:
		push_warning("The current state is calling itself!")
		return
	
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.state_input(event)
