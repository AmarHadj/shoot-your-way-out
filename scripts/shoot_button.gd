extends Node2D

var need_changed_text = false

func _process(delta):
	if !Observer.shootingPhase and need_changed_text:
		self.get_child(0).set_text("shoot")
		
		
# This code will switch into shoot mode and the player will see the results of his guns placement
func _on_button_pressed() -> void:
	Observer.setPhaseToShoot()
	if Observer.shootingPhase:
		self.get_child(0).set_text("stop")
		need_changed_text = true
	if !Observer.shootingPhase:
		self.get_child(0).set_text("shoot")
