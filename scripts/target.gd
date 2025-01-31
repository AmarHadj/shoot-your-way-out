extends Node2D
var is_touched = false

func get_is_touched():
	return is_touched

func  set_is_touched():
	if is_touched :
		is_touched = false
	elif !is_touched :
		is_touched = true
