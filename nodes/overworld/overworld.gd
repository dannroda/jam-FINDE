extends Node3D

@onready var grid_mesh_lib = $GridMap.mesh_library
@onready var water_pink = grid_mesh_lib.find_item_by_name('Water2')
@onready var cells = $GridMap.get_used_cells_by_item(water_pink)
@export var player_life:ProgressBar
@export var player_speed:ProgressBar
@export var player:CharacterBody3D
@export var lose_dialog:ConfirmationDialog
@export var win_dialog:ConfirmationDialog
# Called when the node enters the scene tree for the first time.
func _ready():
	player_speed.max_value = player.max_speed
	player_speed.min_value = player.min_speed
	$AudioLibrary/WaterSound.play()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_instance_valid(player):
		player_speed.value = player.current_speed
#		var player_global = to_global(player.position)
#		var player_cell = Vector2i(player_global.x,player_global.z)
#		for cell in cells:
#			var global_cell = to_global($GridMap.map_to_local(cell))
#			var to_check = Vector2i(global_cell.x,global_cell.z)
#			if player_cell == to_check:
#				print("same")
func _on_player_damage(amount):
	player_life.value -= amount


func _on_confirmation_dialog_canceled():
	get_tree().change_scene_to_file("res://nodes/Scenes/MainScene.tscn")


func _on_confirmation_dialog_confirmed():
	get_tree().change_scene_to_file("res://nodes/overworld/overworld.tscn")


func _on_player_lose():
	lose_dialog.popup_centered()


func _on_confirmation_dialog_about_to_popup():
	for unit in $PlayerNode.get_children():
		unit.queue_free()
	_free_enemies()


func _on_player_win():
	pass # Replace with function body.


func _on_puerto_body_entered(body):
	if body == player:
		win_dialog.popup_centered()
		player.win = true
		player.current_speed = 0
		player.velocity.x = move_toward(player.velocity.x,0, 1)
	#	player.velocity.y = move_toward(player.velocity.y,0, 1)
		player.velocity.z = move_toward(player.velocity.z,0, 1)

		
func _free_enemies():
	for enemy in $Enemies.get_children():
		enemy.queue_free()


func _on_win_dialog_about_to_popup():
	_free_enemies()
