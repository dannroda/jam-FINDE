extends Area3D
enum possbile_direction {UP,DOWN,LEFT,RIGHT}
@export var direction:possbile_direction = possbile_direction.RIGHT
@onready var mesh = $MeshInstance3D
var player
# Called when the node enters the scene tree for the first time.
func _ready():
	match direction:
		possbile_direction.RIGHT:
			rotation.y = PI
		possbile_direction.LEFT:
			rotation.y = PI * 2
		possbile_direction.DOWN:
			rotation.y = PI / 2
		possbile_direction.UP:
			rotation.y = PI / -2
			


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print(get_overlapping_bodies())
	pass


func _on_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
#	print(name)
	for bodi in get_overlapping_bodies():
		if bodi.name == 'Player':
			player = bodi
	if player:
		player.change_direction.emit(direction,true)


func _on_body_shape_exited(body_rid, body, body_shape_index, local_shape_index):
	for bodi in get_overlapping_bodies():
		if bodi.name == 'Player':
			player = bodi
	if player:
		player.change_direction.emit(direction,false)
	
