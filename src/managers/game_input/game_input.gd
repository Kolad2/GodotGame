extends Object

class_name GameInput

static func get_move_input():
	var x = 0
	var y = 0
	if Input.is_action_pressed("ui_up"):
		y += -Input.get_action_strength("ui_up")
	if Input.is_action_pressed("ui_down"):
		y += Input.get_action_strength("ui_down")
	if Input.is_action_pressed("ui_right"):
		x += Input.get_action_strength("ui_right")
	if Input.is_action_pressed("ui_left"):
		x += -Input.get_action_strength("ui_left")
	return Vector2(x, y)
