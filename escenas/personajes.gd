extends CharacterBody2D


const SPEED = 300.0
const VELOCIDAD_GIRO = 10.0
const RADIO = 10000
const DISTANCIA_CAMBIO = 20
const TIEMPO_MAX_INFECTADO = 10

@export var puntos: PackedVector2Array

var target_index
@export var infectado: bool
var angulo
var muerto
var temporizador
var puntos_vuelta



func _ready():
	target_index = 0
	# infectado = false
	angulo = 0
	muerto = false
	temporizador = 0
	
	#self.add_to_group("personajes")
	
	asignar_puntos_vuelta()
	

func _physics_process(delta):
	
	var target
	
	if !muerto:
		if (!infectado):
			target = puntos_vuelta[target_index]

			if position.distance_to(target) < 10 :
				print("CAMBIO RUMBO")
				print(position.distance_to(target))
				target_index = fmod(target_index+1, puntos_vuelta.size())
				target = puntos_vuelta[target_index]

		else:
			angulo = fmod(angulo + (VELOCIDAD_GIRO * delta), 2 * PI)
			target = Vector2(cos(angulo), sin(angulo))*RADIO
		
		velocity = (target - position).normalized() * SPEED	
		move_and_slide()
	
		if infectado:
			temporizador += delta
		
			if temporizador >= TIEMPO_MAX_INFECTADO:
				muerto = true;
				print("ME MUERO")


func _on_area_2d_body_entered(body):
	if body != self:
		print("ENTRO EN AREAAAAAA")
		print(body)
	
	if body != self and !muerto and body.infectado:
		# Me infecto yo
		print("ME INFECTO")
		infectado = true;
		
		# Si al infectarme yo hay otros cerca mia, los infecto
		for bodies in $Area2D.get_overlapping_bodies(): #This one SHOULD get all the bodies in the area.
			#if bodies.is_in_group("personajes"):
			bodies.infectado = true;
			
func asignar_puntos_vuelta():
	puntos_vuelta = puntos;
	
	for i in range(puntos.size() - 2, 0, -1):
		puntos_vuelta.append(puntos[i])
		
	print(puntos_vuelta)
		
