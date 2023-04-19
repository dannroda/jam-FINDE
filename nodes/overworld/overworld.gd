extends Node3D

@onready var grid_mesh_lib = $GridMap.mesh_library
@onready var water_pink = grid_mesh_lib.find_item_by_name('Water2')
@onready var cells = $GridMap.get_used_cells_by_item(water_pink)
@onready var player_speed = $CanvasLayer/HBoxContainer/VBoxContainer/PlayerSpeed
@onready var player_life = $CanvasLayer/HBoxContainer/VBoxContainer/PlayerLife
@onready var player = $Player

# Called when the node enters the scene tree for the first time.
func _ready():
	player_speed.max_value = player.max_speed
	player_speed.min_value = player.min_speed
#	player_speed.step = player.increase_speed_by

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	player_speed.value = player.current_speed

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


func _on_player_damage(amount):
	player_life.value -= amount
