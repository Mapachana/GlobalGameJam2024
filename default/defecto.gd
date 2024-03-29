extends Node

var debug=true

var current_scene = null

var puntuacion
var cont

#signal sumarpunto(punt)

func _ready():
	var root = get_tree().root
	current_scene = root.get_child(root.get_child_count() - 1)
	puntuacion = 0
	cont = 0
	
func reiniciar_puntuacion():
	puntuacion = 0
	cont = 0
	
func sumar_puntuacion():
	print("SUMOOOOOOOOOOOOOOO")
	puntuacion += 1
	#sumarpunto.emit(puntuacion)
	get_tree().call_group("ventana", "mostrar_puntuacion", puntuacion)
	
func contar_infectados():
	cont = 0
	for perso in get_tree().get_nodes_in_group("personajes"):
		if perso.infectado or perso.muerto:
			cont += 1
			
	puntuacion = cont
	get_tree().call_group("ventana", "mostrar_puntuacion", puntuacion)

func goto_scene(path):
	# This function will usually be called from a signal callback,
	# or some other function in the current scene.
	# Deleting the current scene at this point is
	# a bad idea, because it may still be executing code.
	# This will result in a crash or unexpected behavior.

	# The solution is to defer the load to a later time, when
	# we can be sure that no code from the current scene is running:
	call_deferred("_deferred_goto_scene", path)



func _deferred_goto_scene(path):
	# It is now safe to remove the current scene.
	current_scene.free()

	# Load the new scene.
	var s = ResourceLoader.load(path)

	# Instance the new scene.
	current_scene = s.instantiate()

	# Add it to the active scene, as child of root.
	get_tree().root.add_child(current_scene)

	# Optionally, to make it compatible with the SceneTree.change_scene_to_file() API.
	get_tree().current_scene = current_scene
