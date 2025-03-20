@tool
extends Node2D

@onready var sprite = $Sprite2D

@export var texture_id: int = 0:
	set(value):
		if not sprite:
			texture_id = value
			return
		sprite.texture_id = value
		texture_id = sprite.texture_id
		#print(sprite.texture.get_width())
		#print(sprite.texture.get_height() / 2)
		
	
func _ready():
	sprite.texture_id = texture_id
	self.add_to_group("navigation_group")
