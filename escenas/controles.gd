extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Globales.goto_scene("res://escenas/titulo.tscn")
	pass # Replace with function body.


func _on_tuto_pressed():
	Globales.goto_scene("res://niveles/nivel1.tscn")
	pass # Replace with function body.
