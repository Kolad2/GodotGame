extends Node2D


func _process(delta):
	var animated_sprite = get_node("AnimatedSprite2D")
	
	if Input.is_action_pressed("move_up"):
		animated_sprite.animation = "stand_up"
	
	if Input.is_action_pressed("move_down"):
		animated_sprite.animation = "stand_down"
	
	if Input.is_action_pressed("move_right"):
		animated_sprite.animation = "stand_right"
	
	if Input.is_action_pressed("move_left"):
		animated_sprite.animation = "stand_left"
	
