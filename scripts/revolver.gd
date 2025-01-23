extends Node2D

const min_dist = 50
var selected = false
var rest_point
var is_placed
var new_position = -1
var is_rotating
var rotation_angle = 90
var rotation_applied = 0


# Called when the node enters the scene tree for the first time.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	
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
			if new_position >= 0:
				if Observer.weapon_slots[new_position].get_has_weapon():
					Observer.weapon_slots[new_position].set_has_weapon(false)
		else :
			if !is_placed :
				place_gun()
			if is_placed :
				global_position = lerp(global_position, Observer.weapon_slots[new_position].global_position, 10* delta)
			else :
				global_position = lerp(global_position, rest_point.global_position, 10* delta)
				new_position = -1

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			
		if event.button_index == MOUSE_BUTTON_RIGHT and not event.pressed:
			is_rotating = false
			
func set_rest_point(rest_point_choosed : Marker2D):
	rest_point = rest_point_choosed
	
func place_gun():
	for i in range(Observer.weapon_slots.size()):
		if abs(global_position.x - Observer.weapon_slots[i].global_position.x) < min_dist and abs(global_position.y - Observer.weapon_slots[i].global_position.y) < min_dist and !Observer.weapon_slots[i].get_has_weapon():
			is_placed = true
			Observer.weapon_slots[i].set_has_weapon(true)
			new_position = i
			break

func get_rotation_applied():
	return rotation_applied
		
	
