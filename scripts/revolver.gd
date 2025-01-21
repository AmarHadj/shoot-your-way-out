extends Node2D

const min_dist = 50
var selected = false
var rest_point
var is_placed
var new_position


# Called when the node enters the scene tree for the first time.

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_just_pressed("click"):
		selected = true
		
func _physics_process(delta):
	if selected:
		global_position=lerp(global_position, get_global_mouse_position(), 25*delta)
	else :
		place_gun()
		if is_placed :
			global_position = lerp(global_position, new_position.global_position, 10* delta)
			is_placed = false
		else :
			global_position = lerp(global_position, rest_point.global_position, 10* delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			
func set_rest_point(rest_point_choosed : Marker2D):
	rest_point = rest_point_choosed
	
func place_gun():
	for child in Observer.weapon_slots:
		if abs(global_position.x - child.global_position.x) < min_dist and abs(global_position.y - child.global_position.y) < min_dist:
			is_placed = true
			new_position = child
			break
		
	
