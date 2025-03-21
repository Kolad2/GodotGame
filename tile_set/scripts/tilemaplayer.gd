extends TileMapLayer

var cell_cite_big_tile_cell = {}

func _ready():
	test(self)

func is_main_cell(cell):
	return self.get_cell_tile_data(cell) != null

func get_cell_tile_size(cell):
	if self.get_cell_tile_data(cell):
		var source_id = self.get_cell_source_id(cell)
		var atlas_coords = self.get_cell_atlas_coords(cell)
		var atlas = self.tile_set.get_source(source_id) as TileSetAtlasSource
		var tile_size = atlas.get_tile_size_in_atlas(atlas_coords)
		return tile_size
	else:
		var big_tile_cell = cell_cite_big_tile_cell[cell]
		if big_tile_cell:
			return big_tile_cell
	return null

func get_main_cell(cell):
	if is_main_cell(cell):
		return cell
	var big_tile_cell = cell_cite_big_tile_cell[cell]
	if big_tile_cell:
		return big_tile_cell
	return null

func add_big_tile_in_cell(cell):
	var tile_size = self.get_cell_tile_size(cell)
	if tile_size != Vector2i(1, 1):
		print("size: ", tile_size, " cell: ", cell)
		var tile_data = self.get_cell_tile_data(cell)
		var i_max = tile_size.x
		var j_max = tile_size.y
		for i in range(i_max):
			for j in range(j_max):
				var cell_cite = cell + Vector2i(i, j)
				cell_cite_big_tile_cell[cell_cite] = cell
	


func test(tilemap: TileMapLayer):
	var tileset: TileSet = tilemap.tile_set
	var cells = tilemap.get_used_cells()
	for cell in cells:
		self.add_big_tile_in_cell(cell)
