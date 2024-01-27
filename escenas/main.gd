extends Node2D

var puntuacion

# Called when the node enters the scene tree for the first time.
func _ready():
	
	puntuacion = 0
	
	add_to_group("ventana")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func subir_puntuacion():
	print("SUBO UN PUNTO")
	puntuacion += 1
	print(puntuacion)
	var puntos_pantalla = "Teeth infected: %s"%puntuacion
	$Control/Label.text = puntos_pantalla
