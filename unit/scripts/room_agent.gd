@tool
extends Node2D

class_name RoomAgent


signal entered(room: Room)
signal exited(room: Room)

@onready var _area2d: Area2D = Area2D.new()
@onready var _collision_shape: CollisionShape2D = CollisionShape2D.new()
@export var shape: Shape2D
@export_flags_2d_physics var room_layer: int = 0


var z_layer:
	get():
		var unit = self.get_parent()
		if unit is Unit:
			return unit.z_layer
		return 0

func _ready():
	self.add_child(_area2d)
	self._area2d.add_child(_collision_shape)
	_area2d.collision_layer = room_layer
	_area2d.collision_mask = room_layer
	_collision_shape.shape = shape
	#
	self._area2d.body_entered.connect(_entered)
	self._area2d.body_exited.connect(_exited)


func _entered(room: Node2D):
	if room is Room: if self.z_layer == room.z_layer:
			self.entered.emit(room)
			

func _exited(room: Node2D):
	if room is Room: if self.z_layer == room.z_layer:
			self.exited.emit(room)
