extends Node2D


func _process(delta):
	var animated_sprite = get_node("AnimatedSprite2D")
	var dx = 0
	var dy = 0
	
	var norm_v = get_norm_v()
	var direction = get_direction(norm_v)
	if direction == "stand":
		return
		
	position["x"] = position["x"] + 1*norm_v["x"]
	position["y"] = position["y"] + 1*norm_v["y"]
	
	if abs(norm_v["x"]) > abs(norm_v["y"]):
		if norm_v["x"] > 0:
			animated_sprite.animation = "stand_right"
		else:
			animated_sprite.animation = "stand_left"
	else:
		if norm_v["y"] > 0:
			animated_sprite.animation = "stand_down"
		else:
			animated_sprite.animation = "stand_up"
		

func get_direction(norm_v):
	if norm_v["x"] == 0 and norm_v["y"] == 0:
		return "stand"
	if abs(norm_v["x"]) > abs(norm_v["y"]):
		if norm_v["x"] > 0:
			return "right"
		else:
			return "left"
	else:
		if norm_v["y"] > 0:
			return "down"
		else:
			return "up"
	
	

func get_norm_v():
	var norm_dx = 0
	var norm_dy = 0
	if Input.is_action_pressed("move_up"):
		norm_dy = -Input.get_action_strength("move_up")
	
	if Input.is_action_pressed("move_down"):
		norm_dy = Input.get_action_strength("move_down")
	
	if Input.is_action_pressed("move_right"):
		norm_dx = Input.get_action_strength("move_right")
	
	if Input.is_action_pressed("move_left"):
		norm_dx = -Input.get_action_strength("move_left")
	
	return {"x": norm_dx, "y": norm_dy}
	
	
