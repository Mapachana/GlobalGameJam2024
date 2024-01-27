extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var patrol_path: NodePath
@export var puntos: PackedVector2Array
var patrol_points
var patrol_index = 0

func _ready():
	if patrol_path:
		pass
		#patrol_points = get_node(patrol_path).curve.get_baked_points()
		#print(patrol_points)
	
	

func _physics_process(delta):
	if !patrol_path:
		pass
	#print(patrol_points)
	#var target = patrol_points[patrol_index]
	var target = puntos[patrol_index]
	#if position.distance_to(target) < 1:
	#	patrol_index = wrapi(patrol_index + 1, 0, patrol_points.size())
	#	target = patrol_points[patrol_index]
	if (position.distance_to(target) < 1) and (patrol_index < (puntos.size()-1)) :
		patrol_index += 1
		target = puntos[patrol_index]
		velocity = (target - position).normalized() * SPEED
	
	move_and_slide()
	pass
