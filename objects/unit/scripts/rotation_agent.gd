class_name RotationAgent extends Node2D

@export var target_nodes: Array[NodePath] = []


signal _rotated(angle: float)


func rotate_to(angle: float):
	self._rotated.emit(angle)


func _ready():
	self._rotated.connect(self._on_rotated)


func _on_rotated(angle: float):
	for node_path in target_nodes:
		var target = get_node_or_null(node_path)  # Безопасное получение нода
		if target:
			target.rotation = angle  # Применяем поворот
