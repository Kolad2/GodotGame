extends Object
class_name Utils

enum Direction { NULL, LEFT, RIGHT, UP, DOWN }


static func get_direction(velocity: Vector2):
	if velocity.x == 0 and velocity.y == 0:
		return Direction.NULL
	if abs(velocity.x) > abs(velocity.y):
		if velocity.x > 0:
			return Direction.RIGHT
		else:
			return Direction.LEFT
	else:
		if velocity.y > 0:
			return Direction.DOWN
		else:
			return Direction.UP

static func set_sprite_walk_animation(animated_sprite: AnimatedSprite2D, dir: Direction):
	var walk_animation = {
		Direction.RIGHT: "walk_right",
		Direction.LEFT: "walk_left",
		Direction.UP: "walk_up",
		Direction.DOWN: "walk_down",
		}
	animated_sprite.animation = walk_animation[dir]

static func set_sprite_stand_animation(animated_sprite: AnimatedSprite2D, dir: Direction):
	var stand_animation = {
		Direction.RIGHT: "stand_right",
		Direction.LEFT: "stand_left",
		Direction.UP: "stand_up",
		Direction.DOWN: "stand_down",
		}
	animated_sprite.animation = stand_animation[dir]
