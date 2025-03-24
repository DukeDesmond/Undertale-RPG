extends StaticBody2D

@onready var interactable: Area2D = $Interactable
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var interaction_name: String = ""


func _ready() -> void:
	interactable.interact_name = interaction_name
	interactable.interact = _on_interact
	
	
func _on_interact():
	if animation_player.assigned_animation == "chest_closed":
		animation_player.play("chest_opened")
		interactable.is_interactable = false
		print("interacted")
