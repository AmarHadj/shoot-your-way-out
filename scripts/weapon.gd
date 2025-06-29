extends Node2D
@onready var weapon_type: Node2D = $"."
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx: AudioStreamPlayer2D = $SFX
@export var is_revolver = false

const min_dist = 50 # the minimum distance for a weapon to be at a weapon slot to get attached at it
var new_position = -1 #represent the position on the weapon slots array where the weapon will be placed
var selected = false
var inventory_slot # the inventory slot that the weapon will have
var is_placed
var used = false
var bullet_speed = 800


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
		used = false
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
			
# this function will compare the global position of the weapon with the global position of the weapon
# slot and decide if the difference is close enough to attach the weapon to the weapon slot
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
		
func set_used_true():
	if is_revolver:
		animated_sprite_2d.play("shoot")
	else:
		animated_sprite_2d.play("slash")
	sfx.play()
	used = true
	
func get_used():
	return used

func cut_bullet():
		if rotation_applied == 0 :
			Observer.create_bullet(global_position.x,global_position.y -30, 270, 0, -bullet_speed)
			Observer.create_bullet(global_position.x,global_position.y +30, 90, 0, bullet_speed)
			
		if rotation_applied == 90 :
			Observer.create_bullet(global_position.x -30,global_position.y, 180, -bullet_speed, 0)
			Observer.create_bullet(global_position.x +30,global_position.y , 0, bullet_speed, 0)
			
		if rotation_applied == 180 :
			Observer.create_bullet(global_position.x,global_position.y -30, 270, 0, -bullet_speed)
			Observer.create_bullet(global_position.x,global_position.y +30, 90, 0, bullet_speed)
			
		if rotation_applied == 270 :
			Observer.create_bullet(global_position.x -30,global_position.y, 180, -bullet_speed, 0)
			Observer.create_bullet(global_position.x +30,global_position.y , 0, bullet_speed, 0)

		set_used_true()
		
