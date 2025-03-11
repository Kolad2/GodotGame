extends AnimatedSprite2D

func _ready():
	# Устанавливаем анимацию
	animation = "stand_down"  # Имя анимации
	#animation = "Stand_up"  # Имя анимации
	# Запускаем анимацию
	play()
