extends Node2D

signal main_character_changed(new_character: Node2D)

func _ready() -> void:
	NodeRegistry.registr_root(self)
