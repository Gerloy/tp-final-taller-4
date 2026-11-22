extends CharacterBody3D


const SPEED = 2
const JUMP_VELOCITY = 5.0


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("accion") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("arriba", "abajo", "derecha", "izquierda")
	if Input.is_action_pressed("correr"): input_dir = input_dir*2;
	if (input_dir.x != 0) or (input_dir.y != 0):
		$Animacion.play("caminata");
	else:
		$Animacion.stop();
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction.z > 0:
		$Animacion.flip_h = true;
	else:
		$Animacion.flip_h = false;
	if direction:
		velocity.x = direction.x * (SPEED + SPEED * int(Input.is_action_pressed("correr")))
		velocity.z = direction.z * (SPEED + SPEED * int(Input.is_action_pressed("correr")))
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()
