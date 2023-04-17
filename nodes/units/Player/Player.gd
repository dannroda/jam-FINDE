extends CharacterBody3D

@export_range(-3.0,50.0,1.0) var min_speed:float = 0
@export_range(1.0,5.0,0.2) var rotation_speed:float = 10
@export_range(-3.0,50.0,2.0) var max_speed:float = 50
@export_range(0.0,10.0,1.0) var increase_speed_by:float = 5.0
@export_range(0.0,10.0,1.0) var decrease_speed_by:float = 7.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed:float = min_speed

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
#	var direction = Input.get_axis("ui_up","ui_down")
#	var steer_direction = Input.get_axis("ui_left","ui_right")
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	var steer_direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
#	if Input.is_action_pressed("ui_up") and current_speed < max_speed:
	if direction:
		velocity.z = direction.z * current_speed
		velocity.x = direction.x * current_speed
		current_speed += increase_speed_by * delta
#	else:
#		velocity.z = move_toward(velocity.z, 0, current_speed)
	print(steer_direction)
	print(rotation_degrees)
	if steer_direction:
		rotation_degrees.y -= steer_direction.x



	move_and_slide()


func _process(delta):
	if not Input.is_action_pressed("ui_up") and current_speed > min_speed:
		current_speed -= decrease_speed_by * delta
		
