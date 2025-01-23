extends Node2D

const min_dist = 50 # the minimum distance for a gun to be at a weapon slot to get attached at it
var new_position = -1 #represent the position on the weapon slots array where the gun will be placed
var selected = false
var inventory_slot # the inventory slot that the gun will have
var is_placed

var rotation_angle = 90
var rotation_applied = 0

# manage the mouse click input
func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int):
	if !Observer.shootingPhase:	
		if Input.is_action_just_pressed("click"):
			selected = true
		if Input.is_action_just_pressed("rotate"):
			rotation_applied = rotation_applied + rotation_angle
			self.set_rotation_degrees(rotation_applied)
			if rotation_applied == 360:
				rotation_applied = 0
		
func _physics_process(delta):
	if !Observer.shootingPhase:
		if selected:
			global_position=lerp(global_position, get_global_mouse_position(), 25*delta)
			is_placed = false		
			# if new_position < 0 then no weapon slot has been assigned
			if new_position >= 0:
				if Observer.weapon_slots[new_position].get_has_weapon():
					Observer.weapon_slots[new_position].set_has_weapon(false)
		else :
			if !is_placed :
				place_gun()
			if is_placed :
				global_position = lerp(global_position, Observer.weapon_slots[new_position].global_position, 10* delta)
			else :
				global_position = lerp(global_position, inventory_slot.global_position, 10* delta)
				new_position = -1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			
# this function will compare the global position of the gun with the global position of the weapon
# slot and decide if the difference is close enough to attach the gun to the weapon slot
func place_gun():
	for i in range(Observer.weapon_slots.size()):
		if abs(global_position.x - Observer.weapon_slots[i].global_position.x) < min_dist and abs(global_position.y - Observer.weapon_slots[i].global_position.y) < min_dist and !Observer.weapon_slots[i].get_has_weapon():
			is_placed = true
			Observer.weapon_slots[i].set_has_weapon(true)
			new_position = i
			break

func get_rotation_applied():
	return rotation_applied
	
func set_rest_point(inventory_slot_choosed : Marker2D):
	inventory_slot = inventory_slot_choosed
		
	
