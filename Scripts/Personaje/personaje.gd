extends CharacterBody3D


const SPEED = 2
#const JUMP_VELOCITY = 5.0

@export var dialogo_interaccion:Array;
@export var puede_interactuar = false;

func process(_delta:float) -> void:
	if puede_interactuar:
		if Input.is_action_just_pressed("accion"): #and dialogo_interaccion.size() > 0:
			print("Entra a dialogo");
			Global.comenzarDialogo(dialogo_interaccion);


func _physics_process(delta: float) -> void:
	if Global.getEstado() == "NORMAL":
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		#if Input.is_action_just_pressed("accion") and is_on_floor():
		#	velocity.y = JUMP_VELOCITY

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
		if puede_interactuar:
			if Input.is_action_just_pressed("accion"): #and dialogo_interaccion.size() > 0:
				print("Entra a dialogo");
				Global.comenzarDialogo(dialogo_interaccion);


func enColision(area: Area3D) -> void:
	print("Entro a algo");
	if (area.label) and (area.label == "Interaccion"):
		print("Entro a area interactuable");
		print(area);
		dialogo_interaccion = area.dialogo;
		puede_interactuar = true;
	pass # Replace with function body.

func saleColision(_area: Area3D) -> void:
	print("Salio de area interactuable");
	dialogo_interaccion = [];
	puede_interactuar = false;
	pass # Replace with function body.
