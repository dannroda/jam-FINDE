extends Node3D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AudioLibrary.get_node("WaterSound").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	get_tree().change_scene_to_file("res://nodes/overworld/overworld.tscn")


func _on_quit_pressed():
	get_tree().quit()
