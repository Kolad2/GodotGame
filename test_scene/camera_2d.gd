extends Camera2D

@onready var target = get_node("%HeroScene")  # Цель (персонаж)

@export var smooth_speed: float = 0.1  # Скорость сглаживания

func _process(_delta):
	if target:
		#position = target.position
		position = position.lerp(target.position, smooth_speed)
