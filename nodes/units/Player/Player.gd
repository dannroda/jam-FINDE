extends CharacterBody3D

@export_range(-3.0,50.0,1.0) var min_speed:float = 0
@export_range(1.0,5.0,0.2) var rotation_speed:float = 2
@export_range(-3.0,50.0,2.0) var max_speed:float = 50
@export_range(0.0,10.0,1.0) var increase_speed_by:float = 10.0
@export_range(0.0,10.0,1.0) var decrease_speed_by:float = 3.0

signal change_direction(direction,on_current)
signal damage(amount)
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")
var current_speed:float = min_speed
var current_direction
var on_current:bool = false
enum possbile_direction {UP,DOWN,LEFT,RIGHT}
var on_box_current:possbile_direction
@onready var life:int = 90
@onready var buque = $Buque
@onready var default_speed_increase = increase_speed_by

func _ready():
	change_direction.connect(force_move)
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

#	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
#		velocity.y = JUMP_VELOCITY
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(0, 0, input_dir.y)).normalized()
	var steer_direction = (transform.basis * Vector3(input_dir.x, 0, 0)).normalized()
	if not on_current and direction and Input.is_action_pressed("ui_up"):
		velocity.z = direction.z * current_speed
		velocity.x = direction.x * current_speed
		current_direction = direction
		if current_speed < max_speed:
			current_speed += increase_speed_by * delta
	if current_speed < 0:
		current_speed = 0
	if is_on_wall():
#		print("WALLL")
		current_speed /= 5
		velocity.x = move_toward(velocity.x, velocity.x - 200, current_speed * 10)
		velocity.z = move_toward(velocity.z, velocity.z - 200, current_speed * 10)
		
		damage.emit(30)

	if not on_current and current_direction and current_speed > min_speed:
		current_speed -= decrease_speed_by * delta
		velocity.z = current_direction.z * current_speed
		velocity.x = current_direction.x * current_speed
	if Input.is_action_pressed("ui_left"):
		rotation.y += rotation_speed * delta
	if Input.is_action_pressed("ui_right"):
		rotation.y -= rotation_speed * delta

	move_and_slide()

func update_direction():
	velocity.z *= increase_speed_by
#func _process(delta):
#	if $RayCast3D.is_colliding():
#		print("collide")
#		print($RayCast3D.get_collider())

func _process(delta):
#	if on_box_current:
	pass
func force_move(box_direction = null,current:bool = false):
	print('entra')
	print(box_direction)
	on_box_current = box_direction
	on_current = current
	if current_speed < 0:
		current_speed += increase_speed_by * 10
	match on_box_current:
		possbile_direction.RIGHT:
#			velocity.x += 20
			velocity.x = move_toward(velocity.x, abs(velocity.x) * 3, current_speed * 10)
		possbile_direction.LEFT:
#			velocity.x -= 20
			velocity.x = move_toward(velocity.x, abs(velocity.x) * -3, current_speed * 10)
		possbile_direction.DOWN:
#			velocity.z += 20
			velocity.z = move_toward(velocity.z, abs(velocity.z) * 3, current_speed * 10)
		possbile_direction.UP:
#			velocity.z -= 20
			velocity.z = move_toward(velocity.z, abs(velocity.z) * -3, current_speed * 10)
#	on_current = false
	

#	if velocity.x <= 0:
#	velocity.x = move_toward(velocity.x, abs(velocity.x) * -2, current_speed * 10)
#	if velocity.x >= 0:
#	velocity.x = move_towa/rd(velocity.x, abs(velocity.x) * 2, current_speed * 10)
#	velocity.z = move_toward(velocity.z, velocity.z * 20, current_speed * 20)


func _on_damage(amount):
	life -= amount
	match life:
		90:
			buque.no_damage()
		60:
			buque.one_damage()
		30:
			buque.two_damage()
		0:
			buque.three_damage()
