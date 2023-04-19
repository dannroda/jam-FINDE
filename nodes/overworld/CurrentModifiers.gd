extends Node3D

@export_node_path var player_node
# Called when the node enters the scene tree for the first time.
func _ready():
	var modifiers = get_children()
	for modifier in modifiers:
		pass
#	player_node.change_direction.emit(direction)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
