class_name Unit extends CharacterBody2D

@export var health: float = 100.
@export var max_health: float = 100. 
@export var z_layer: int = 0
@export var speed = 100
@export var facing: Direction = Direction.DOWN


var walk_animation = {
	Direction.TOP: "walk_top", Direction.TOP_RIGHT: "walk_top_right",
	Direction.RIGHT: "walk_right", Direction.DOWN_RIGHT: "walk_down_right",
	Direction.DOWN: "walk_down", Direction.DOWN_LEFT: "walk_down_left",
	Direction.LEFT: "walk_left",  Direction.TOP_LEFT: "walk_top_left",
	}

var stand_animation = {
	Direction.TOP: "stand_top", Direction.TOP_RIGHT: "stand_top_right",
	Direction.RIGHT: "stand_right", Direction.DOWN_RIGHT: "stand_down_right",
	Direction.DOWN: "stand_down", Direction.DOWN_LEFT: "stand_down_left",
	Direction.LEFT: "stand_left",  Direction.TOP_LEFT: "stand_top_left",
}
