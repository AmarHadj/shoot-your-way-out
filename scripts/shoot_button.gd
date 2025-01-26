extends Node2D


# This code will switch into shoot mode and the player will see the results of his guns placement
func _on_button_pressed() -> void:
	Observer.setPhaseToShoot()
