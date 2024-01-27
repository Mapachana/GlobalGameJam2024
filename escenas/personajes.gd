extends CharacterBody2D


const SPEED = 300.0
const VELOCIDAD_GIRO = 10.0
const RADIO = 1000000000
const DISTANCIA_CAMBIO = 10
const TIEMPO_MAX_INFECTADO = 10

@export var puntos: PackedVector2Array

var target_index
@export var infectado: bool
var angulo
var muerto
var temporizador
var puntos_vuelta



func _ready():
	# Inicializo variables
	target_index = 0
	#infectado = false
	angulo = 0
	muerto = false
	temporizador = 0
	
	self.add_to_group("personajes")
	
	# Van y vuelven por la ruta indicada
	asignar_puntos_vuelta()
	

func _physics_process(delta):
	
	var target
	
	# Me muevo si no estoy muerto
	if !muerto:
		# Si no estoy infectado me muevo en ruta fija
		if (!infectado):
			target = puntos_vuelta[target_index]

			if position.distance_to(target) < 10 :
				#print("CAMBIO RUMBO")
				#print(position.distance_to(target))
				target_index = fmod(target_index+1, puntos_vuelta.size())
				target = puntos_vuelta[target_index]
		# Si estoy infectado me muevo en circulos
		else:
			angulo = fmod(angulo + (VELOCIDAD_GIRO * delta), 2 * PI)
			target = Vector2(cos(angulo), sin(angulo))*RADIO
		
		velocity = (target - position).normalized() * SPEED	
		
		if (velocity.x < 0):
			print("A izquierda")
		else:
			print("a derecha")
		
		move_and_slide()
	
		# Si se esta infectado se inicia la cuenta atras para morir
		if infectado:
			temporizador += delta
		
			if temporizador >= TIEMPO_MAX_INFECTADO:
				muerto = true;
				#print("ME MUERO")


func _on_area_2d_body_entered(body):
	#print("ENTRO EN AREAAAAAA")
	# Si se me acerca alguien infectado y estoy vivo
	if body != self and !muerto and body.is_in_group("personajes") and body.infectado and !infectado:
		# Me infecto yo
		#print("ME INFECTO")
		infectado = true;
		get_tree().call_group("ventana", "subir_puntuacion")
		
		# Si al infectarme yo hay otros cerca mia, los infecto
		for bodies in $Area2D.get_overlapping_bodies(): #This one SHOULD get all the bodies in the area.
			if bodies.is_in_group("personajes") and !bodies.infectado:
				bodies.infectado = true;
				get_tree().call_group("ventana", "subir_puntuacion")
			
# Dados los puntos de la ruta crea un array con la ruta de ida+vuelta
func asignar_puntos_vuelta():
	puntos_vuelta = puntos;
	
	for i in range(puntos.size() - 2, 0, -1):
		puntos_vuelta.append(puntos[i])
		
	#print(puntos_vuelta)
		
