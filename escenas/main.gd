extends Node2D

#signal sumarpunto
# Called when the node enters the scene tree for the first time.

const TIEMPO_MAXIMO = 20

var personajes_escena
var contador

func _ready():
	
	add_to_group("ventana")
	
	contador = 0
	
	#Bad Juanjo
	if get_node_or_null("Muelas")!= null:
		asignar_camino_extra()
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	contador += delta
	
	if contador >= TIEMPO_MAXIMO:
		Globales.goto_scene("res://escenas/creditos.tscn")
	pass

func mostrar_puntuacion(punt):
	var puntos_pantalla = "Teeth laughing: %s"%punt
	$Control/Label.text = puntos_pantalla
	
	personajes_escena = get_tree().get_nodes_in_group("personajes")
	
	var i = 0
	var todos_muertos = true
	while i < len(personajes_escena) and todos_muertos:
		if !personajes_escena[i].muerto and !personajes_escena[i].infectado:
			todos_muertos = false
		i += 1
	
	if todos_muertos:
		Globales.goto_scene("res://escenas/creditos.tscn")
	else:
		contador = 0
		
func asignar_camino_extra():
	
	
	for muela in $Muelas.get_children():
	
		#Buscamos pasos, para actualizar las rutas:
		var hay_pasos=false
		for paso in muela.get_children():
			if paso is Marker2D:
				hay_pasos=true
		
		if hay_pasos:		
			muela.puntos.clear()
			muela.puntos.append(muela.global_position)
			for ipaso in range(0,muela.get_child_count()):
				var paso=muela.get_child(ipaso)
				print(paso.name)
				if paso is Marker2D:
					print("+")
					muela.puntos.append(paso.global_position)
			muela.asignar_puntos_vuelta()
			
func _on_sumarpunto():
	print("HA llamado")
	mostrar_puntuacion(Globales.puntuacion)
