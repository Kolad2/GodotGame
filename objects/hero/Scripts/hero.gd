extends Unit

# Сохраняем ссылку на AnimatedSprite2D
@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var stairs_agent: StairsAgent = $StairsAgent
@onready var room_agent: RoomAgent = $RoomAgent
@onready var rotation_agent: RotationAgent = $RotationAgent


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
	var move_input = GameInput.get_move_input()
	var move_direction: Direction = Direction.from_vector(move_input)
	
	if move_direction == Direction.NULL:
		set_stand_animation(facing)
		return
	else:
		facing = move_direction
	velocity = speed*move_input
	move_and_slide()
	set_walk_animation(facing)
	
	
	self.rotation_agent.rotate_to(move_input.angle())


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
	self.animation_player.current_animation = walk_animation[dir]


func set_stand_animation(dir):
	self.animation_player.current_animation = stand_animation[dir]



	
