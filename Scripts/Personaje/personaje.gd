extends CharacterBody3D


const SPEED = 2
#const JUMP_VELOCITY = 5.0

@export var dialogo_interaccion:Array;
@export var puede_interactuar = false;

var flipea;

var esta_en_dialogo = false;

func process(_delta:float) -> void:
	if puede_interactuar and !esta_en_dialogo:
		if Input.is_action_just_pressed("accion"):
			Global.comenzarDialogo(dialogo_interaccion);
	if Global.getEstado() == Global.ESTADO.DIALOGO:
		esta_en_dialogo = true;
		$Animacion.stop();
	else:
		esta_en_dialogo = false;


func _physics_process(_delta: float) -> void:
	if Global.getEstado() == Global.ESTADO.NORMAL:
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * _delta

		#if Input.is_action_just_pressed("accion") and is_on_floor():
		#	velocity.y = JUMP_VELOCITY

		var input_dir := Input.get_vector("arriba", "abajo", "derecha", "izquierda")
		if Input.is_action_pressed("correr"): input_dir = input_dir*2;
		if (input_dir.x != 0) or (input_dir.y != 0):
			$Animacion.play("caminata");
		else:
			$Animacion.stop();
		var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
		if direction.x > 0:
			flipea = true;
		elif direction.x < 0:
			flipea = false;
		if flipea:
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
			if Input.is_action_just_pressed("accion"):
				Global.comenzarDialogo(dialogo_interaccion);


func enColision(area: Area3D) -> void:
	if (area.label) and (area.label == "Interaccion"):
		dialogo_interaccion = area.dialogo;
		puede_interactuar = true;
	if (area.label) and (area.label == "Dialogo-scripteado"):
		$Animacion.stop();
		area.iniciar();

func saleColision(_area: Area3D) -> void:
	dialogo_interaccion = [];
	puede_interactuar = false;
