extends Node2D

@export var pipe_scene : PackedScene

const SCROLL_SPEED : int = 5
const PIPE_DELAY : int = 100
const PIPE_RANGE : int = 200

var game_over : bool
var game_running : bool
var screen_size : Vector2i
var groung_height : int
var scroll : int
var pipes : Array

func _ready() -> void:
	screen_size = get_window().size
	groung_height = $Ground.get_node("Sprite2D").texture.get_height()
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
						check_top()

func _process(delta: float) -> void:
	if game_running:
		scroll += SCROLL_SPEED
		if scroll >= screen_size.x:
			scroll -= screen_size.x
		$Ground.position.x = -scroll
		for pipe in pipes:
			pipe.position.x -= SCROLL_SPEED

func _on_pipe_timer_timeout() -> void:
	generate_pipes()

func _on_ground_hit() -> void:
	$Bird.falling = false
	stop_game()

func new_game() -> void:
	game_over = false
	game_running = false
	scroll = 0
	pipes.clear()
	generate_pipes()
	$Bird.reset()

func start_game() -> void:
	game_running = true
	$Bird.flying = true
	$Bird.flap()
	$PipeTimer.start()

func stop_game() -> void:
	$PipeTimer.stop()
	$Bird.flying = false
	game_running = false
	game_over = true

func generate_pipes() -> void:
	var pipe = pipe_scene.instantiate()
	pipe.position.x = screen_size.x + PIPE_DELAY
	pipe.position.y = (screen_size.x - groung_height) / 2 + randi_range(-PIPE_RANGE, PIPE_RANGE)
	pipe.hit.connect(bird_hit)
	add_child(pipe)
	pipes.append(pipe)

func check_top() -> void:
	if $Bird.position.y < 0:
		$Bird.falling = true
		stop_game()
	
func bird_hit() -> void:
	$Bird.falling = true
	stop_game()
