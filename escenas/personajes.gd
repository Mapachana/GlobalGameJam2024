extends CharacterBody2D


const SPEED = 300.0

@export var puntos: PackedVector2Array

var target_index
var infectado
var radio
var velocidad_giro
var angulo


func _ready():
	target_index = 0
	infectado = true
	radio = 1000000
	velocidad_giro = 10
	angulo = 0

func _physics_process(delta):
	
	var target
	if (!infectado):
		target = puntos[target_index]

		if (position.distance_to(target) < 1) and (target_index < (puntos.size()-1)) :
			print("YA")
			print(position.distance_to(target))
			target_index += 1
			target = puntos[target_index]

	else:
		angulo = fmod(angulo + (velocidad_giro * delta), 2 * PI)
		target = Vector2(cos(angulo), sin(angulo))*radio
		
	velocity = (target - position).normalized() * SPEED	
	move_and_slide()


func _on_area_2d_body_entered(body):
	if body.infectado:
		# Me infecto yo
		self.infectado = true;
		
		# Si al infectarme yo hay otros cerca mia, los infecto
		for bodies in $Area2D.get_overlapping_bodies(): #This one SHOULD get all the bodies in the area.
			bodies.infectado = true;
