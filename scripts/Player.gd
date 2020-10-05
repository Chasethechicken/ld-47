extends KinematicBody2D

const WALK_FORCE = 5000
const WALK_MAX_SPEED = 800
const STOP_FORCE = 5000
const JUMP_SPEED = 1400

const AIR_FACTOR = 0.15

var velocity = Vector2()

signal game_over

onready var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	# Horizontal movement code. First, get the player's input.
	var walk = WALK_FORCE * (Input.get_action_strength("move_right") - Input.get_action_strength("move_left"))
	# Slow down the player if they're not trying to move.
	if is_on_floor():
		if abs(walk) < WALK_FORCE * 0.2:
			# The velocity, slowed down a bit, and then reassigned.
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta)
		else:
			velocity.x += walk * delta
	else:
		if abs(walk) < WALK_FORCE * 0.2:
			# The velocity, slowed down a bit, and then reassigned.
			velocity.x = move_toward(velocity.x, 0, STOP_FORCE * delta * AIR_FACTOR)
		else:
			velocity.x += walk * delta * AIR_FACTOR
	# Clamp to the maximum horizontal movement speed.
	velocity.x = clamp(velocity.x, -WALK_MAX_SPEED, WALK_MAX_SPEED)

	# Vertical movement code. Apply gravity.
	velocity.y += gravity * delta

	# Move based on the velocity and snap to the ground.
	velocity = move_and_slide_with_snap(velocity, Vector2.DOWN, Vector2.UP)

	# Check for jumping. is_on_floor() must be called after movement code.
	if is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = -JUMP_SPEED


func _on_Area2D_area_entered(area):
	if area.is_in_group("lava"):
		emit_signal("game_over")
	
	if area.is_in_group("meteor"):
		emit_signal("game_over")
