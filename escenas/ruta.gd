extends Node2D


var ruta=[]

enum {sin_iniciar,iniciado,final}

var estado=sin_iniciar

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pinchar"):
		comenzar_ruta()
	elif Input.is_action_pressed("pinchar"):
		seguir_ruta()
	elif Input.is_action_just_released("pinchar"):
		parar_ruta()	

func comenzar_ruta():
	ruta=[get_viewport().get_mouse_position()]
	
func seguir_ruta():
	pass

func parar_ruta():
	pass
	
func _on_input_event(viewport, event, shape_idx):
	pass
			
