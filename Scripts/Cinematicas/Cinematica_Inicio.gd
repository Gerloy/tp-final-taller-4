extends Node3D

var mati;
var dialogos:Array;
@export var dialogo_ui:Node;

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	mati = $Mati;
	dialogos = [
		"Mati: No quedan más papitas...",
		"Mati: Diez minutos hasta que busque partida. Voy al 24hs y vuelvo"
	];
	dialogo_ui = load("res://Prefabs/UI/dialogo.tscn").instantiate();
	dialogo_ui.init(dialogos);
	self.add_child(dialogo_ui);
	Global.estado = Global.ESTADO.CINEMATICA;
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if !dialogo_ui:
		mati.get_node("Animacion").play("caminata");
		mati.get_node("Animacion").flip_h = true;
		#var objetivo = $Marker3D.get_global_position();
		mati.global_position = mati.global_position.move_toward($Marker3D.get_global_position(),2*_delta);
		await get_tree().create_timer(1.5).timeout;
		Global.estado = Global.ESTADO.NORMAL;
		var node = load("res://Scenes/mapa_general.tscn").instantiate();
		get_tree().change_scene_to_node(node);
	pass
