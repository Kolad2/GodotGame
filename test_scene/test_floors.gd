extends Node2D

@onready var wall_tile_floor_1 = $WallMapFloor1
@onready var wall_tile_floor_2 = $WallMapFloor2
@onready var cover_tile_floor_2 = $MapСoverFloor2

func _ready() -> void:
	var root_tile_set = wall_tile_floor_2.tile_set
	var tile_set_floor_2 = root_tile_set.duplicate(true)
	tile_set_floor_2 = set_tile_set_floor_2(tile_set_floor_2)
	wall_tile_floor_2.tile_set = tile_set_floor_2
	cover_tile_floor_2.tile_set = tile_set_floor_2
	

func set_tile_set_floor_2(tile_set):
	# Collision mask
	tile_set.set_physics_layer_collision_layer(0, 1 << 1)
	tile_set.set_physics_layer_collision_mask(0, 1 << 1)
	tile_set.set_physics_layer_collision_layer(1, 0)
	tile_set.set_physics_layer_collision_mask(1, 0)
	# Navigation mask
	tile_set.set_navigation_layer_layers(0, 0)
	return tile_set
