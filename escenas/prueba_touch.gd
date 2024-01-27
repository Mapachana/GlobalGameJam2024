extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if  (event is InputEventScreenDrag): # (event is InputEventScreenTouch) or
		# if event.pressed:
		$MuelaParada1Centrada.position=event.position
