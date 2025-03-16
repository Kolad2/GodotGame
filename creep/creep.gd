extends CharacterBody2D
var utils = preload("uid://cm1orhpn24cv3")

@export var speed: float = 100.0
@export var target_position: Vector2 = Vector2(500, 300)
@export var direction: Utils.Direction = Utils.Direction.DOWN
# 
@onready var animated_sprite = $AnimatedSprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
#
func _ready():
	navigation_agent.target_position = target_position


func _process(delta):
	if navigation_agent.is_navigation_finished():
		return
	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var vec_direction: Vector2 = (next_path_position - global_position).normalized()
	velocity = vec_direction * speed
	var _direction = utils.get_direction(vec_direction)
	if _direction == Utils.Direction.NULL:
		utils.set_sprite_stand_animation(animated_sprite, self.direction)
		return
	self.direction = _direction
	utils.set_sprite_walk_animation(animated_sprite, self.direction)
	move_and_slide()
	if navigation_agent.is_navigation_finished():
		utils.set_sprite_stand_animation(animated_sprite, self.direction)
