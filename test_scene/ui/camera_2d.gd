extends Camera2D


#world_node.connect("character_changed", self, "_on_character_changed")

var target # Цель (персонаж)
@export var smooth_speed: float = 0.1  # Скорость сглаживания


func _on_character_changed(character: Node2D):
	print(1)
	target = character
	enabled = true
	

func _process(_delta):
	if target:
		#position = target.position
		position = position.lerp(target.position, smooth_speed)
	else:
		if enabled == true:
			enabled = false
