extends Node3D

@onready var buque_mesh = $RootNode/BUQUEBUQUE
@export var materials:Array[StandardMaterial3D] 
# Called when the node enters the scene tree for the first time.
func _ready():
	pass
#	print(buque_mesh.get_surface_override_material(0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_key_pressed(KEY_1):
		print("no damage")
		no_damage()
	if Input.is_key_pressed(KEY_2):
		print("first damage")
		one_damage()
	if Input.is_key_pressed(KEY_3):
		print("second damage")
		two_damage()
	if Input.is_key_pressed(KEY_4):
		three_damage()

func no_damage():
		buque_mesh.set_surface_override_material(0,materials[0])
func one_damage():
		buque_mesh.set_surface_override_material(0,materials[1])
func two_damage():
		buque_mesh.set_surface_override_material(0,materials[2])
func three_damage():
	get_parent().get_node('Collision').disabled = true
