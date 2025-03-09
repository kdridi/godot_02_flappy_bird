extends Node2D

func _ready() -> void:
	new_game()

func new_game() -> void:
	$Bird.reset()
