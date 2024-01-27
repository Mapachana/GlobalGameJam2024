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
var velocidad=5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pinchar"):
		comenzar_ruta()
	elif Input.is_action_pressed("pinchar"):
		seguir_ruta()
	elif Input.is_action_just_released("pinchar"):
		parar_ruta()	
		
	if estado==final:
		if siguiente_objetivo!=null:
			if $MuelaParada.position.distance_to(siguiente_objetivo)<offset:
				indice_paso=clamp(indice_paso+1,0,total_pasos-1)
				siguiente_objetivo=$Line2D.get_point_position(indice_paso)
			$MuelaParada.position=$MuelaParada.position+(siguiente_objetivo-$MuelaParada.position).normalized()*velocidad
			
		#$Path2D/PathFollow2D.set_progress(progreso)
		#progreso=clamp(progreso+delta,0,1.0)
		
func comenzar_ruta():
	var punto=get_viewport().get_mouse_position()
	ruta=[punto]
	estado=sin_iniciar
	$Line2D.add_point(punto)
	$MuelaParada.global_position=punto
	curva=$Path2D.get_curve()
	primer_punto_ruta=punto
	curva.add_point(Vector2.ZERO)
	ultimo_punto=punto
	#$Path2D.points.add_point(Vector2.ZERO)
	
func seguir_ruta():
	var punto=get_viewport().get_mouse_position()
	
	if punto.distance_to(ultimo_punto)>=intervalo_puntos:	
		ruta.append(punto)
		estado=iniciado
		$Line2D.add_point(punto)
		curva.add_point(punto-primer_punto_ruta)
		#$Path2D.points.add_point(punto-primer_punto_ruta)
		ultimo_punto=punto
	
func parar_ruta():
	var punto=get_viewport().get_mouse_position()
	ruta.append(punto)
	estado=final
	$Line2D.add_point(punto)
	curva.add_point(punto-primer_punto_ruta)
	#$Path2D.points.add_point(punto-primer_punto_ruta)
		
	$Path2D.set_curve(curva)
	total_pasos=$Line2D.get_point_count()
	indice_paso=0
	siguiente_objetivo=$Line2D.get_point_position(indice_paso)
	
func _on_input_event(viewport, event, shape_idx):
	pass
			
