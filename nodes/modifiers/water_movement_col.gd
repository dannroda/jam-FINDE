extends Area3D
enum possbile_direction {UP,DOWN,LEFT,RIGHT}
@export var direction:possbile_direction = possbile_direction.UP
@onready var mesh = $MeshInstance3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
