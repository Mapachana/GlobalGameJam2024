extends Area2D


enum {cerrado, inestable,escape,vacio}
var estado=cerrado

@export
var alcance=3

@export
var tiempo_inestable=3
@export 
var tiempo_escape=5

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	match estado:
		cerrado:
			estado=inestable
			$Timer.start(tiempo_inestable)	
		inestable:
			estado=escape
			$Timer.start(tiempo_escape)	
			explota()
		escape:
			estado=vacio
			vaciar()
			
func explota():
	$particulas.emitting=false
	
func vaciar():
	tiempo_escape=0
	tiempo_inestable=0
	$particulas.emitting=false

func _on_input_event(viewport, event, shape_idx):
	pass # Replace with function body.
