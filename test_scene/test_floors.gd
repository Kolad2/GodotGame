@tool
extends Node2D

@onready var wall_tile_floor_1 = $WallMapFloor1
@onready var wall_tile_floor_2 = $WallMapFloor2
@onready var cover_tile_floor_2 = $MapCoverFloor2

var tilemaps_floor_1 = []
var tilemaps_floor_2 = []
var tilemaps_floor_3 = []

func _ready() -> void:
	var tile_set = preload("uid://d2ki4qat4ap4d")
	var root_tile_set = wall_tile_floor_2.tile_set
	var tile_set_floor_2 = tile_set.duplicate(true)
	tile_set_floor_2 = set_tile_set_floor_2(tile_set_floor_2)
	wall_tile_floor_2.tile_set = tile_set_floor_2
	cover_tile_floor_2.tile_set = tile_set_floor_2
	self.add_to_group("navigation_group")
	#
	for child in self.get_children():
		if child.z_index == 0:
			tilemaps_floor_1.append(child)
		if child.z_index == 1:
			tilemaps_floor_2.append(child)
		if child.z_index == 2:
			tilemaps_floor_3.append(child)
			
		#print("vl", child.visibility_layer)
	

func hide_floor_2():
	for tile_map in tilemaps_floor_2:
		tile_map.visible = false


func hide_floor_3():
	for tile_map in tilemaps_floor_3:
		tile_map.visible = false


func set_tile_set_floor_2(tile_set):
	# Collision mask
	tile_set.set_physics_layer_collision_layer(0, 1 << 1)
	tile_set.set_physics_layer_collision_mask(0, 1 << 1)
	tile_set.set_physics_layer_collision_layer(1, 0)
	tile_set.set_physics_layer_collision_mask(1, 0)
	return tile_set
