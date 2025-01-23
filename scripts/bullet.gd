extends CharacterBody2D


const SPEED = 300.0 # set to 2000.0 for the final result
var x_movment = SPEED
var y_movment = 0

func _physics_process(delta):
	if Observer.shootingPhase:
		velocity.x = x_movment
		velocity.y = y_movment
		move_and_slide()

func _on_area_2d_area_entered(area: Area2D):
	if area.name == "shoot_area" :
		
		# sets the position of the bullet on the gun barrel
		for child in area.get_children():
			if child.name == "barrel":
				self.global_position = child.global_position
		
		var gun_rotation = area.get_parent().get_parent().get_rotation_applied()
		self.set_rotation_degrees(gun_rotation)

		if gun_rotation == 0 :
			x_movment = SPEED
			y_movment = 0
			
		if gun_rotation == 270 :
			y_movment = -SPEED
			x_movment = 0
		
		if gun_rotation == 90 :
			y_movment = SPEED
			x_movment = 0
			
		if gun_rotation == 180 :
			x_movment = -SPEED
			y_movment = 0
