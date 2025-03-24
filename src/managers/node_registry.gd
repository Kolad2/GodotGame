extends Object
class_name NodeRegistry

static var root_node: Node2D = null

static func registr_root(node: Node2D):
	root_node = node
	
static func get_root():
	return root_node
