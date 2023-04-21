extends CharacterBody3D

@export var player:CharacterBody3D
@export var buque_mesh:MeshInstance3D
@export var materials:Array[StandardMaterial3D] 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var target_position
var dead:bool = false
var current_speed
func _physics_process(delta):
	# Add the gravity.
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	target_position = player.position
	target_position.y = global_transform.origin.y
	look_at(target_position)
	if player.position.y < 1:
		current_speed = player.current_speed
		position = position.lerp(player.position, delta * current_speed / 4)
	else:
		position = position.lerp(Vector3(player.position.x / 2,position.y,player.position.z/ 2), delta * .6)
		
#	rotation = rotation.lerp(player.rotation, delta * player.current_speed / 4)
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
#	if velocity.z != player.velocity.z:
#		rotation.y = move_toward(rotation.y,player.rotation.y,.3)

#	move_and_slide()

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
#	$Collision.disabled = true
	await get_tree().create_timer(2).timeout
	queue_free()
