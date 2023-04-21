extends CharacterBody3D

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
@export var target:CharacterBody3D
var target_position:Vector3
var speed = 4
var follow_target:bool = false
func _ready():
	if not is_instance_valid(target):
		target = get_parent().target
func _physics_process(delta):
	
	if not is_on_floor():
		velocity.y -= gravity * delta
	if follow_target:
		target_position = target.position
		target_position.y = global_transform.origin.y
		look_at(target_position)
		if target.position.y < 1:
			position = position.lerp(target.position, delta * speed / 4)
		else:
			position = position.lerp(Vector3(target.position.x / 2,position.y,target.position.z/ 2), delta * .8)



func _on_area_3d_body_entered(body):
	$Area3D.get_overlapping_bodies()
	follow_target = true


