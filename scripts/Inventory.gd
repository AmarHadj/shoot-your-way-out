extends Control

var revolvers = []
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Observer._ready()
	revolvers = get_tree().get_nodes_in_group("Weapons")

	for i in range(revolvers.size()) :
		revolvers[i].set_rest_point(Observer.inventory_space[i])
