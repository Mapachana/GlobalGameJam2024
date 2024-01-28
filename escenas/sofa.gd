extends CharacterBody2D


@export var flip_horizontal: bool
@export var flip_vertical: bool
@export var color = Vector3(1, 1, 1)


func _ready():
	if flip_horizontal:
		$Sprite2D.flip_h = true;
	else:
		$Sprite2D.flip_h = false;
		
	if flip_vertical:
		$Sprite2D.flip_v = true;
	else:
		$Sprite2D.flip_v = false;
		
	$Sprite2D.modulate = Color(color.x, color.y, color.z)
	
	pass


func _physics_process(delta):
	pass
