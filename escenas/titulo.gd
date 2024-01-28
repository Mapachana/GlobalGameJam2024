extends TextureRect


func _ready():
	pass


func _process(delta):
	pass
	
# Empezar partida
func _on_button_pressed():
	Globales.goto_scene("res://niveles/nivel3.tscn")
	pass # Replace with function body.

# Ver controles
func _on_button_2_pressed():
	Globales.goto_scene("res://escenas/controles.tscn")
	pass # Replace with function body.
