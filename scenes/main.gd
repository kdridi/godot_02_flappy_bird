extends Node2D

var game_over
var game_running

func _ready() -> void:
	new_game()

func new_game() -> void:
	game_over = false
	game_running = false
	$Bird.reset()

func _input(event: InputEvent) -> void:
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()

func start_game() -> void:
	game_running = true
	$Bird.flying = true
	$Bird.flap()
