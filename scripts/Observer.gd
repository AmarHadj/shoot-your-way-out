extends Node

var shootingPhase = false
var inventory_space
var weapon_slots
var bullet_packed = load("res://Assets/Bullet.tscn")


#set the phase to shooting phase
func setPhaseToShoot():
	if !shootingPhase :
		shootingPhase = true
	elif shootingPhase :
		shootingPhase = false
		

func set_slots() -> void:
	inventory_space = get_tree().get_nodes_in_group("zone")
	weapon_slots = get_tree().get_nodes_in_group("Weapon_slot")

func create_bullet(positionx, positiony, rotation, speedx, speedy):
		bullet_packed = preload("res://Assets/Bullet.tscn")
		var bullet = bullet_packed.instantiate()
		bullet.global_position.x = positionx
		bullet.global_position.y = positiony
		bullet.set_rotation_degrees(rotation)
		bullet.set_movment(speedx, speedy)
		bullet.z_index = 1
		add_child(bullet)
