extends Node2D


var ruta=[]

const intervalo_puntos=10
const offset=5

enum {sin_iniciar,iniciado,final}

var estado=sin_iniciar
var curva:Curve2D
var progreso=0
var primer_punto_ruta=null
var ultimo_punto=null

var total_pasos=-1
var indice_paso=0
var siguiente_objetivo=null

@export
var contenido=100

@export
var velocidad=5

@export var initial_position = Vector2.ZERO

var tiempo_carga = 0
const MIN_TIEMPO = 0.3

var explotada = false
var tiempo_exp = 0
const TIEMPO_DESAPARECER = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	setup_ruta()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	tiempo_carga += delta
	
	if tiempo_carga >= MIN_TIEMPO:
		if explotada:
			tiempo_exp += delta
			if tiempo_exp >= TIEMPO_DESAPARECER:
				queue_free()
	
		if estado!=final:
			if Input.is_action_pressed("pinchar"):
				seguir_ruta()
			elif Input.is_action_just_released("pinchar"):
				parar_ruta()	
		else:
			if Input.is_action_pressed("pinchar"):
				if contenido>0:
					$MuelaParada/AnimationPlayerHumo.play("flusss")	
					explotada = true
					

		
	if estado==final:
		
		if siguiente_objetivo!=null:
			if $MuelaParada.position.distance_to(siguiente_objetivo)<offset:
				#indice_paso=clamp(indice_paso+1,0,total_pasos-1)
				indice_paso += 1
				siguiente_objetivo=$Line2D.get_point_position(indice_paso)
			if indice_paso < len(ruta):
				$MuelaParada.position=$MuelaParada.position+(siguiente_objetivo-$MuelaParada.position).normalized()*velocidad
			else:
				$MuelaParada/AnimationPlayerHumo.play("flusss")
				explotada = true
				
				
		else:
			$MuelaParada/AnimationPlayerHumo.play("flusss")
			explotada = true
			

				
		#$Path2D/PathFollow2D.set_progress(progreso)
		#progreso=clamp(progreso+delta,0,1.0)

func setup_ruta():
	var punto=initial_position
	ruta=[punto]
	estado=sin_iniciar
	$Line2D.add_point(punto)
	$MuelaParada.global_position=punto
	curva=$Path2D.get_curve()
	primer_punto_ruta=punto
	curva.add_point(primer_punto_ruta)
	ultimo_punto=punto
	


func comenzar_ruta():
	var punto=get_viewport().get_mouse_position()
	ruta=[punto]
	estado=sin_iniciar
	$Line2D.add_point(punto)
	$MuelaParada.global_position=punto
	curva=$Path2D.get_curve()
	primer_punto_ruta=punto
	#curva.add_point(Vector2.ZERO)
	ultimo_punto=punto
	#$Path2D.points.add_point(Vector2.ZERO)
	
func seguir_ruta():
	var punto=get_viewport().get_mouse_position()
	
	if punto.distance_to(ultimo_punto)>=intervalo_puntos:	
		ruta.append(punto)
		estado=iniciado
		$Line2D.add_point(punto)
		#curva.add_point(punto)
		#$Path2D.points.add_point(punto-primer_punto_ruta)
		ultimo_punto=punto
	
func parar_ruta():
	var punto=get_viewport().get_mouse_position()
	ruta.append(punto)
	estado=final
	$Line2D.add_point(punto)
	#curva.add_point(punto-primer_punto_ruta)
	#$Path2D.points.add_point(punto-primer_punto_ruta)
		
	$Path2D.set_curve(curva)
	total_pasos=$Line2D.get_point_count()
	indice_paso=1
	siguiente_objetivo=$Line2D.get_point_position(indice_paso)
	
func _on_input_event(viewport, event, shape_idx):
	pass

func _on_area_2d_body_entered(body):
	if body.is_in_group("personajes") and !body.muerto and !body.infectado:
		body.infectado = true;
		Globales.sumar_puntuacion()
		print("BOMBONA")
		Globales.contar_infectados()

func _unhandled_input(event):
	if estado!=final:
		if event is InputEventScreenTouch:
			if event.pressed==true:
				#comenzar_ruta()
				pass
			elif event.pressed==false:
				parar_ruta()			
		if  (event is InputEventScreenDrag): # (event is InputEventScreenTouch) or
			seguir_ruta()	
			
