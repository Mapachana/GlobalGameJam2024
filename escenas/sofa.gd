extends Sprite2D


@export var flip_horizontal: bool
@export var flip_vertical: bool
@export var color = Vector3(1, 1, 1)


func _ready():
	if flip_horizontal:
		self.flip_h = true;
	else:
		self.flip_h = false;
		
	if flip_vertical:
		self.flip_v = true;
	else:
		self.flip_v = false;
		
	self.modulate = Color(color.x, color.y, color.z)
	
	pass


func _physics_process(delta):
	pass
