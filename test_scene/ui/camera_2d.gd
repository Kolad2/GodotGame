extends Camera2D

var target # Цель (персонаж)
@export var smooth_speed: float = 0.1  # Скорость сглаживания

var function_list: Set = Set.new()

func _ready():
	function_list.add(connet_to_root)

func _on_character_changed(character: Node2D):
	target = character
	enabled = true


func connet_to_root():
	var root = NodeRegistry.get_root()
	if root:
		root.main_character_changed.connect(_on_character_changed)
		function_list.remove(connet_to_root)
		print("root_connected")


func _process(_delta):
	for f in function_list.array:
		f.call()
		
	if target:
		position = target.position
		#var joystick = %VirtualJoystick
		#print(joystick)
		#print(joystick._base)
		#joystick._base.position = get_viewport().get_camera_2d().position
		#position = position.lerp(target.position, smooth_speed)
	#else:
		#if enabled == true:
			#enabled = false
