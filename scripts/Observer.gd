extends Node

var shootingPhase = false
var inventory_space
var weapon_slots
var reset_level = true


#set the phase to shooting phase
func setPhaseToShoot():
	if !shootingPhase :
		shootingPhase = true
		

func _ready() -> void:
	inventory_space = get_tree().get_nodes_in_group("zone")
	weapon_slots = get_tree().get_nodes_in_group("Weapon_slot")

#func _process(delta: float):
	#if reset_level:
		#inventory_space = get_tree().get_nodes_in_group("zone")
		#weapon_slots = get_tree().get_nodes_in_group("Weapon_slot")
		#reset_level = false
