extends Area3D

@export var label = "Dialogo-scripteado"
@export var dialogo:Array;

#var activado;

func _on_body_entered(_body: Node3D) -> void:
	if _body.name == "personaje":
		Global.comenzarDialogo(dialogo);
		self.queue_free();
	print(_body.name);
	pass # Replace with function body.

func iniciar():
	Global.comenzarDialogo(dialogo);
	self.queue_free();
