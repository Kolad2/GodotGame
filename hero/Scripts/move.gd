extends Unit

enum Direction { NULL, LEFT, RIGHT, UP, DOWN }

# Сохраняем ссылку на AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var stairs_agent: StairsAgent = $StairsAgent
@onready var room_agent: RoomAgent = $RoomAgent
@export var direction: Direction = Direction.DOWN


func _ready():
	# Room hit box
	room_agent.entered.connect(_room_entered)
	room_agent.exited.connect(_room_left)
	# Stairs Agent
	stairs_agent.ascented.connect(_stairs_ascented)
	stairs_agent.descented.connect(_stairs_descented)
	# Создаем таймер 
	var timer = Timer.new()
	timer.wait_time = 1.0 # Задержка 1 секунда
	timer.one_shot = true  # Таймер сработает только один раз
	timer.timeout.connect(test)  # Подключаем сигнал timeout к функции
	add_child(timer)  # Добавляем таймер в сцену
	timer.start()


func test():
	var root = NodeRegistry.get_root()
	root.main_character_changed.emit(self)
	print("signal emmited")


func _room_entered(room: Room):
	print("room_entered")
	room.building.hide_upper_floors(self.z_index)
			

func _room_left(room: Room):
	print("room_left")
	room.building.show_upper_floors(self.z_layer)
		

func _stairs_ascented(_room: Node2D):
	print("stairs_ascented")
	set_stairs_up()


func _stairs_descented(_room: Node2D):
	print("stairs_descented")
	set_stairs_down()


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


func set_stairs_up():
	self.set_collision_mask_value(1, false)
	self.set_collision_layer_value(1, false)
	self.set_collision_mask_value(2, true)
	self.set_collision_layer_value(2, true)
	self.z_index = self.z_index + 1
	self.z_layer = self.z_layer + 1


func set_stairs_down():
	self.set_collision_mask_value(1, true)
	self.set_collision_layer_value(1, true)
	self.set_collision_mask_value(2, false)
	self.set_collision_layer_value(2, false)
	self.z_index = self.z_index - 1
	self.z_layer = self.z_layer - 1


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
	if Input.is_action_pressed("ui_up"):
		norm_dy = -Input.get_action_strength("ui_up")
	elif Input.is_action_pressed("ui_down"):
		norm_dy = Input.get_action_strength("ui_down")
	if Input.is_action_pressed("ui_right"):
		norm_dx = Input.get_action_strength("ui_right")	
	elif Input.is_action_pressed("ui_left"):
		norm_dx = -Input.get_action_strength("ui_left")
	return Vector2(norm_dx, norm_dy)
	
