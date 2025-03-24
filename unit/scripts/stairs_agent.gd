@tool
extends Node2D

class_name StairsAgent

enum StairsPosition { NULL, LOWER, CENTER, UPPER }

signal ascented(room: Room)
signal descented(room: Room)

@onready var _area_stairs_lower: Area2D = Area2D.new()
@onready var _area_stairs_upper: Area2D = Area2D.new()
@onready var _shape_stairs_lower: CollisionShape2D = CollisionShape2D.new()
@onready var _shape_stairs_upper: CollisionShape2D = CollisionShape2D.new()
@export var shape: Shape2D
		
@export_flags_2d_physics var stairs_lower_layer: int = 0
@export_flags_2d_physics var stairs_upper_layer: int = 0
var stairs_position = StairsPosition.NULL
var z_layer:
	get():
		var unit = self.get_parent()
		if unit is Unit:
			return unit.z_layer
		return 0

func _ready() -> void:
	# Stairs lower hit box
	self.add_child(_area_stairs_lower)
	_area_stairs_lower.add_child(_shape_stairs_lower)
	_area_stairs_lower.body_entered.connect(_stairs_lower_entered)
	_area_stairs_lower.body_exited.connect(_stairs_lower_left)
	_area_stairs_lower.collision_layer = stairs_lower_layer
	_area_stairs_lower.collision_mask = stairs_lower_layer
	_shape_stairs_lower.shape = shape
	# Stairs upper hit box
	self.add_child(_area_stairs_upper)
	_area_stairs_upper.add_child(_shape_stairs_upper)
	_area_stairs_upper.body_entered.connect(_stairs_upper_entered)
	_area_stairs_upper.body_exited.connect(_stairs_upper_left)
	_area_stairs_upper.collision_layer = stairs_upper_layer
	_area_stairs_upper.collision_mask = stairs_upper_layer
	_shape_stairs_upper.shape = shape


func _stairs_lower_entered(room: Node2D):
	if room is Room:
		if self.stairs_position == StairsPosition.NULL:
			self.ascented.emit(room)
			#print("stairs_lower_entered")
			self.stairs_position = StairsPosition.LOWER
		if self.stairs_position == StairsPosition.UPPER:
			self.stairs_position = StairsPosition.CENTER
		

func _stairs_lower_left(room: Node2D):
	if room is Room:
		if self.stairs_position == StairsPosition.LOWER:
			self.stairs_position = StairsPosition.NULL
			self.descented.emit(room)
			#print("stairs_left_lower")
		if self.stairs_position == StairsPosition.CENTER:
			self.stairs_position = StairsPosition.UPPER


func _stairs_upper_entered(room: Node2D):
	if room is Room:
		#print("stairs_upper_entered")
		if self.stairs_position == StairsPosition.NULL:
			self.stairs_position = StairsPosition.UPPER
		if self.stairs_position == StairsPosition.LOWER:
			self.stairs_position = StairsPosition.CENTER
	
	
func _stairs_upper_left(room: Node2D):
	if room is Room:
		#print("stairs_upper_left")
		if self.stairs_position == StairsPosition.UPPER:
			self.stairs_position = StairsPosition.NULL
		if self.stairs_position == StairsPosition.CENTER:
			self.stairs_position = StairsPosition.LOWER
