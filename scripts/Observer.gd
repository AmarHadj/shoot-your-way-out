extends Node

var shootingPhase = false
var win = false
var inventory_space
var weapon_slots
var targets
var bullets
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
	targets = get_tree().get_nodes_in_group("Targets")
	bullets = get_tree().get_nodes_in_group("Bullets")

func create_bullet(positionx, positiony, rotation, speedx, speedy):
		bullet_packed = preload("res://Assets/Bullet.tscn")
		var bullet = bullet_packed.instantiate()
		bullet.global_position.x = positionx
		bullet.global_position.y = positiony
		bullet.set_rotation_degrees(rotation)
		bullet.set_movment(speedx, speedy)
		bullet.z_index = 1
		bullets.append(bullet)
		add_child(bullet)

func verify_win():
	for target in targets :
		if target.get_is_touched() :
			win = true
		elif !target.get_is_touched():
			win = false
			break
	
	if bullets.is_empty() and win:
		get_tree().current_scene.win()
		setPhaseToShoot()
	elif bullets.is_empty() and !win:
		get_tree().current_scene.lose()
		setPhaseToShoot()
