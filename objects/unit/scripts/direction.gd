extends Resource
class_name Direction

enum ID {
	NULL,
	TOP, TOP_RIGHT,
	RIGHT, DOWN_RIGHT,
	DOWN, DOWN_LEFT,
	LEFT, TOP_LEFT
}

const TAN_22_5 = 0.41421356237
@export var id: ID = ID.NULL

static func _create_direction(dir_id: ID) -> Direction:
	var dir = Direction.new()
	dir.id = dir_id
	return dir

static func from_vector(v: Vector2):
	if v.x == 0 and v.y == 0:
		return Direction.NULL
		
	var abs_x = abs(v.x)
	var abs_y = abs(v.y)
	
	if  abs_y < abs_x * TAN_22_5:
		return Direction.RIGHT if v.x > 0 else Direction.LEFT
	elif TAN_22_5 * abs_y > abs_x:
		return Direction.DOWN if v.y > 0 else Direction.TOP
	# Диагональные направления (если не горизонтально и не вертикально)
	else:
		if v.x > 0:
			return Direction.DOWN_RIGHT if v.y > 0 else Direction.TOP_RIGHT
		else:
			return Direction.DOWN_LEFT if v.y > 0 else Direction.TOP_LEFT


static func from_vector_x4(v: Vector2):
	if v.x == 0 and v.y == 0:
		return Direction.NULL
	if abs(v.x) > abs(v.y):
		if v.x > 0:
			return Direction.RIGHT
		else:
			return Direction.LEFT
	else:
		if v.y > 0:
			return Direction.DOWN
		else:
			return Direction.TOP

static var NULL: Direction = _create_direction(ID.NULL)
static var TOP: Direction = _create_direction(ID.TOP)
static var TOP_RIGHT: Direction = _create_direction(ID.TOP_RIGHT)
static var RIGHT: Direction = _create_direction(ID.RIGHT)
static var DOWN_RIGHT: Direction = _create_direction(ID.DOWN_RIGHT)
static var DOWN: Direction = _create_direction(ID.DOWN)
static var DOWN_LEFT: Direction = _create_direction(ID.DOWN_LEFT)
static var LEFT: Direction = _create_direction(ID.LEFT)
static var TOP_LEFT: Direction = _create_direction(ID.TOP_LEFT)
