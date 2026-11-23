extends Control

var id = 0;
var dialogos:Array;
var dialogo_actual:String;

func init(_dialogos:Array) -> void:
	id = 0;
	dialogos = _dialogos;
	cambiarDialogo();

# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
#	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("accion"):
		id += 1;
		if id >= dialogos.size():
			terminar();
		else:
			cambiarDialogo();
	pass

func terminar():
	Global.finalizarDialogo();
	self.queue_free();
	pass

func cambiarDialogo():
	dialogo_actual = dialogos[id];
	$Texto.text = dialogo_actual;
