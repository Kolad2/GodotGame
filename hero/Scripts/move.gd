extends CharacterBody2D

enum Direction { NULL, LEFT, RIGHT, UP, DOWN }
#enum Animation { STAND, WALK, RUN }

# Сохраняем ссылку на AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var room_in_box: Area2D = $RoomInBox
@onready var room_out_box: Area2D = $RoomOutBox
@export var direction: Direction = Direction.DOWN


func _ready():
	room_in_box.body_entered.connect(_room_entered)
	room_out_box.body_entered.connect(_room_left)


func _room_entered(body):
	if body.z_index == self.z_index:
		set_stairs_up()
		# print("entered")
	
func _room_left(body):
	if body.z_index < self.z_index:
		set_stairs_down()
		# print("left")


func _process(_delta):
	var speed = 100
	var norm_speed = get_norm_velocity()
	var move_direction = get_direction(norm_speed)
	if move_direction == Direction.NULL:
		set_stand_animation(direction)
		return
	else:
		direction = move_direction
	velocity = speed*norm_speed
	move_and_slide()
	set_walk_animation(direction)
	

func set_stairs_down():
	self.set_collision_mask_value(1, true)
	self.set_collision_layer_value(1, true)
	self.set_collision_mask_value(2, false)
	self.set_collision_layer_value(2, false)
	self.z_index = self.z_index - 1


func set_stairs_up():
	self.set_collision_mask_value(1, false)
	self.set_collision_layer_value(1, false)
	self.set_collision_mask_value(2, true)
	self.set_collision_layer_value(2, true)
	self.z_index = self.z_index + 1


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
	
func get_norm_velocity():
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
	return Vector2(norm_dx, norm_dy)
	
