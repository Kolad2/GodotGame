@tool
extends Sprite2D

var tree_uids = [
	"uid://c1tx0rpx00qch",  # tree type 1
	"uid://cspqm3u638ds8",  # tree type 2
	"uid://c15y2q7ffidsw"   # tree type 3
]

@export var texture_id: int:
	set(value):
		print(value)
		texture_id = clamp(value, 0, tree_uids.size() - 1)
		texture = ResourceLoader.load(tree_uids[texture_id])
		
