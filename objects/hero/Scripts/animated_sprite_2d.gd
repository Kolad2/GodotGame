extends AnimatedSprite2D

func _ready():
	# Устанавливаем анимацию
	#animation = "stand_down"  # Имя анимации
	#animation = "Stand_up"  # Имя анимации
	# Запускаем анимацию
	play()


func _process(_delta):
	pass
	#if animation == "walk_left":
		#scale.x = -abs(scale.x)  # Отразить по горизонтали
	#else:
		#scale.x = abs(scale.x)
