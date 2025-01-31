extends Button


func _on_pressed() -> void:
	Observer.win = false
	get_tree().change_scene_to_file("res://Scenes/Level_" + str(get_tree().current_scene.name.to_int() + 1)  + ".tscn")
	
