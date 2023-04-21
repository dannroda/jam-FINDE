extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var target:CharacterBody3D
var target_position:Vector3
var speed = 4
func _physics_process(delta):
	if not is_on_floor():
		velocity.y -= gravity * delta
	target_position = target.position
	target_position.y = global_transform.origin.y
	look_at(target_position)
	if target.position.y < 1:
		position = position.lerp(target.position, delta * speed / 4)
	else:
		position = position.lerp(Vector3(target.position.x / 2,position.y,target.position.z/ 2), delta * .8)
