@tool
extends Sprite2D

var tree_uids = [
	"uid://c1tx0rpx00qch",  # tree type 1
	"uid://cspqm3u638ds8",  # tree type 2
	"uid://c15y2q7ffidsw"   # tree type 3
]

@export var texture_id: int=0:
	set(value):
		texture_id = clamp(value, 0, tree_uids.size() - 1)
		texture = ResourceLoader.load(tree_uids[texture_id])
		var shift_y = - texture.get_height()
		var shift_x = - texture.get_width() / 2
		position = Vector2(shift_x, shift_y)
