extends Node2D

#signal sumarpunto
# Called when the node enters the scene tree for the first time.
func _ready():
	
	add_to_group("ventana")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func mostrar_puntuacion(punt):
	var puntos_pantalla = "Teeth infected: %s"%punt
	$Control/Label.text = puntos_pantalla


func _on_sumarpunto():
	print("HA llamado")
	mostrar_puntuacion(Globales.puntuacion)
