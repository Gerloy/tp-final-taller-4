extends Node

enum ESTADO {
	NORMAL = 0,
	DIALOGO = 1,
	CINEMATICA = 2
};

var estado:ESTADO;

func comenzarDialogo(_dialogos:Array):
	await get_tree().create_timer(0.1).timeout;
	estado = ESTADO.DIALOGO;
	#Aca se va a instanciar el dialogo que va a hacer todo
	var dialogo = load("res://Prefabs/UI/dialogo.tscn").instantiate();
	dialogo.init(_dialogos);
	get_node("/root").add_child(dialogo);

func finalizarDialogo():
	await get_tree().create_timer(0.1).timeout;
	estado = ESTADO.NORMAL;

func comenzarCinematica():
	estado = ESTADO.CINEMATICA;

func finalizarCinematica():
	estado = ESTADO.NORMAL;

func getEstado():
	return estado;
	#if estado == ESTADO.NORMAL:
		#return "NORMAL";
	#elif estado == ESTADO.DIALOGO:
		#return "DIALOGO";
