@tool
extends Node2D

@onready var sprite = $Sprite2D

@export var texture_id: int:
	set(value):
		if not sprite:
			return
		sprite.texture_id = value
		texture_id = sprite.texture_id
		
	
func _ready():
	sprite.texture_id = texture_id
