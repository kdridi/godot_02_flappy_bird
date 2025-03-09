extends CharacterBody2D

const GRAVITY : int = 1000
const START_POSITION : Vector2 = Vector2(100, 400)
const FLAP_SPEED : int = -500
const MAX_VELOCITY : int = 600

var flying : bool
var falling : bool

func _ready() -> void:
	reset()

func _physics_process(delta: float) -> void:
	if flying or falling:
		velocity.y += GRAVITY * delta
		if velocity.y > MAX_VELOCITY:
			velocity.y = MAX_VELOCITY
		if flying:
			set_rotation(deg_to_rad(velocity.y * 0.05))
			$AnimatedSprite2D.play()
		elif falling:
			set_rotation(PI/2)
			$AnimatedSprite2D.stop()
		move_and_collide(velocity * delta)
	else:
		$AnimatedSprite2D.stop()

func reset() -> void:
	flying = false
	falling = false
	position = START_POSITION
	set_rotation(0)

func flap() -> void:
	velocity.y = FLAP_SPEED
