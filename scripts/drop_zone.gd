extends Marker2D
var has_weapon = false

func _draw():
	draw_circle(Vector2.ZERO, 50, Color.DARK_BLUE)
func set_has_weapon(placed : bool):
	has_weapon = placed

func get_has_weapon():
	return has_weapon
