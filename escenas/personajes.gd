extends CharacterBody2D


const SPEED = 300.0

@export var puntos: PackedVector2Array

var target_index

func _ready():
		target_index = 0

	
	

func _physics_process(delta):

	var target = puntos[target_index]

	if (position.distance_to(target) < 1) and (target_index < (puntos.size()-1)) :
		target_index += 1
		target = puntos[target_index]
		velocity = (target - position).normalized() * SPEED
	
	move_and_slide()
