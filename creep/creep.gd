extends CharacterBody2D
var utils = preload("uid://cm1orhpn24cv3")

@export var speed: float = 100.0
@export var target_position: Vector2 = Vector2(250, 500)
@export var direction: Utils.Direction = Utils.Direction.DOWN
#
@onready var animated_sprite = $AnimatedSprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var navigation_timer: Timer = $NavigationTimer
#
var path_point: Vector2
#
func _ready():
	navigation_agent.target_position = target_position
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))


func _process(_delta):
	if navigation_agent.is_navigation_finished():
		return
	
	path_point = navigation_agent.get_next_path_position()
	var vec_direction: Vector2 = self.to_local(path_point).normalized()
	var _velocity = vec_direction * speed
	navigation_agent.set_velocity(_velocity)
	
	var direction = utils.get_direction(vec_direction)
	if direction == Utils.Direction.NULL:
		utils.set_sprite_stand_animation(animated_sprite, self.direction)
		return
	self.direction = direction
	utils.set_sprite_walk_animation(animated_sprite, self.direction)
	
	

func _on_velocity_computed(safe_velocity: Vector2) -> void:
	self.velocity = safe_velocity
	self.move_and_slide()
	if navigation_agent.is_navigation_finished():
		utils.set_sprite_stand_animation(animated_sprite, self.direction)
