extends Node2D

enum Direction { NULL, LEFT, RIGHT, UP, DOWN }
#enum Animation { STAND, WALK, RUN }

# Сохраняем ссылку на AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D
@export var direction: Direction = Direction.DOWN

func _process(delta):
	var norm_v = get_norm_v()
	var move_direction = get_direction(norm_v)
	if move_direction == Direction.NULL:
		set_stand_animation(direction)
		return
	else:
		direction = move_direction
	position["x"] = position["x"] + 1*norm_v["x"]
	position["y"] = position["y"] + 1*norm_v["y"]
	set_walk_animation(direction)
		

func set_walk_animation(dir):
	var stand_animation = {
		Direction.RIGHT: "walk_right",
		Direction.LEFT: "walk_left",
		Direction.UP: "walk_up",
		Direction.DOWN: "walk_down",
		}
	animated_sprite.animation = stand_animation[dir]

func set_stand_animation(dir):
	var stand_animation = {
		Direction.RIGHT: "stand_right",
		Direction.LEFT: "stand_left",
		Direction.UP: "stand_up",
		Direction.DOWN: "stand_down",
		}
	animated_sprite.animation = stand_animation[dir]

func get_direction(norm_v):
	if norm_v["x"] == 0 and norm_v["y"] == 0:
		return Direction.NULL
	if abs(norm_v["x"]) > abs(norm_v["y"]):
		if norm_v["x"] > 0:
			return Direction.RIGHT
		else:
			return Direction.LEFT
	else:
		if norm_v["y"] > 0:
			return Direction.DOWN
		else:
			return Direction.UP
	
	

func get_norm_v():
	var norm_dx = 0
	var norm_dy = 0
	if Input.is_action_pressed("move_up"):
		norm_dy = -Input.get_action_strength("move_up")
	elif Input.is_action_pressed("move_down"):
		norm_dy = Input.get_action_strength("move_down")
	if Input.is_action_pressed("move_right"):
		norm_dx = Input.get_action_strength("move_right")	
	elif Input.is_action_pressed("move_left"):
		norm_dx = -Input.get_action_strength("move_left")
	return {"x": norm_dx, "y": norm_dy}
	
	
