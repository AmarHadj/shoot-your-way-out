extends Node2D
@onready var player: Node2D = $"../Player"

# This code will switch into shoot mode and the player will see the results of his guns placement
func _on_button_pressed() -> void:
	if !Observer.win and !Observer.shootingPhase:
		player.shoot_animation()
