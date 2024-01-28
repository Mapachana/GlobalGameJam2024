extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready():
	var texto_punt = "Score: %s"%Globales.puntuacion
	$LabelScore.text = texto_punt
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_button_pressed():
	Globales.goto_scene("res://escenas/titulo.tscn")
	pass # Replace with function body.
