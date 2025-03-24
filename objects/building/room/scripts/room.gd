extends TileMapLayer

class_name Room

var building: Building
var z_layer: int:
	get():
		return self.z_index


func get_floor():
	return self.z_index
