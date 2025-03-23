extends Node2D

class_name Building

var floors = []

func _ready() -> void:
	var tile_set = preload("uid://d2ki4qat4ap4d")
	for child in self.get_children():
		if child is Room:
			var floor_num = child.get_floor()
			create_new_floors(floor_num + 1 - floors.size())
			child.building = self
			floors[child.get_floor()].append(child)


func hide_upper_floors(floor_num: int):
	var num_floors = floors.size()
	if floor_num >= num_floors - 1:
		return
	for i in range(floor_num+1, num_floors):
		for room in floors[i]:
			room.visible = false


func show_upper_floors(floor_num: int):
	var num_floors = floors.size()
	if floor_num >= num_floors - 1:
		return
	for i in range(floor_num+1, num_floors):
		for room in floors[i]:
			room.visible = true


func create_new_floors(num: int):
	if num >= 0:
		for i in range(num):
			var floor = []
			floors.append(floor)
		return true
	return false
