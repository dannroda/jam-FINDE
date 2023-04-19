extends Node3D

@onready var grid_mesh_lib = $GridMap.mesh_library
@onready var water_pink = grid_mesh_lib.find_item_by_name('Water2')
@onready var cells = $GridMap.get_used_cells_by_item(water_pink)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	var currents = $CurrentModifiers.get_children()
#	for current in currents:
#		current.body_entered.connect(_update_direction)
##	print(water_pink)
##	print($GridMap.mesh_library.get_item_shapes(water_pink))
#	print(grid_mesh_lib.get_item_shapes(water_pink))
#	print(to_global($GridMap.map_to_local(cells[0])))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	print(to_global($Player.position))
#	print($Player.position)
	var player_global = to_global($Player.position)
	var player_cell = Vector2i(player_global.x,player_global.z)
#	print(player_global)
	for cell in cells:
#		print(cell)
		var global_cell = to_global($GridMap.map_to_local(cell))
#		print(global_cell)
		var to_check = Vector2i(global_cell.x,global_cell.z)
		if player_cell == to_check:
			print("same")

func _update_direction(body):
	print(body)
#	$Player.change_direction.emit()
