extends Node2D

var selected = false
var rest_point

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
		global_position = lerp(global_position, rest_point.global_position, 10* delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
			selected = false
			
func set_rest_point(rest_point_choosed : Marker2D):
	rest_point = rest_point_choosed
	
