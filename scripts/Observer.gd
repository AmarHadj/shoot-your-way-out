extends Node

var shootingPhase = false
var rest_nodes


#set the phase to shooting phase
func setPhaseToShoot():
	if !shootingPhase :
		shootingPhase = true

func _ready():
	rest_nodes = get_tree().get_nodes_in_group("zone")
