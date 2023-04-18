extends CharacterBody3D

@export_range(-3.0,50.0,1.0) var min_speed:float = 0
@export_range(1.0,5.0,0.2) var rotation_speed:float = 3
@export_range(-3.0,50.0,2.0) var max_speed:float = 50
@export_range(0.0,10.0,1.0) var increase_speed_by:float = 10.0
@export_range(0.0,10.0,1.0) var decrease_speed_by:float = 3.0

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed:float = min_speed
var current_direction

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	var steer_direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if direction:
		current_direction = direction
		velocity.z = direction.z * current_speed
		velocity.x = direction.x * current_speed
		if current_speed < max_speed:
			current_speed += increase_speed_by * delta
			
#	if Input.is_action_pressed("ui_up"):
#		if current_speed < max_speed:
#			current_speed += increase_speed_by * delta
#		velocity.z -= current_speed * delta
#	if Input.is_action_pressed("ui_down"):
#		velocity.z += current_speed * delta
	if Input.is_action_pressed("ui_left"):
		rotation.y += rotation_speed * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= rotation_speed * delta

	move_and_slide()
		
func _process(delta):
	print(current_direction)
	print(velocity)
	print(current_speed)
	if current_speed < 0:
		current_speed = 0
	if current_speed > min_speed:
		current_speed -= decrease_speed_by * delta
		velocity.z = current_direction.z * current_speed
		velocity.x = current_direction.x * current_speed
