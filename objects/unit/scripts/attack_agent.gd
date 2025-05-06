@tool  # <-- Важно! Без этого не будет работать в редакторе
extends Area2D

class_name DamageAgent


func _ready() -> void:
	pass

func hit():
	var areas = self.get_overlapping_areas()
	
