extends CharacterBody2D

const START_POSITION = Vector2(100, 400)

func _ready() -> void:
	reset()

func reset() -> void:
	position = START_POSITION
