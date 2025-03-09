extends Node2D

const SCROLL_SPEED : int = 5

var game_over : bool
var game_running : bool
var screen_size : Vector2i
var scroll : int

func _ready() -> void:
	screen_size = get_window().size
	new_game()

func _input(event: InputEvent) -> void:
	if game_over == false:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
				if game_running == false:
					start_game()
				else:
					if $Bird.flying:
						$Bird.flap()

func _process(delta: float) -> void:
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll -= screen_size.x
		$Ground.position.x = -scroll

func new_game() -> void:
	game_over = false
	game_running = false
	scroll = 0
	$Bird.reset()

func start_game() -> void:
	game_running = true
	$Bird.flying = true
	$Bird.flap()
