extends CharacterBody2D
@onready var lose_ray_cast: RayCast2D = $Lose_ray_cast



const SPEED = 300.0 # set to 2000.0 for the final result
var x_movment = SPEED
var y_movment = 0
var spawn_point
var second_bullet

func _ready():
	spawn_point = global_position

func _physics_process(delta):
	if Observer.shootingPhase:
		velocity.x = x_movment
		velocity.y = y_movment
		move_and_slide()
		
		if lose_ray_cast.is_colliding():
			get_tree().change_scene_to_file("res://Scenes/Level_" + str(get_tree().current_scene.name.to_int()) + ".tscn")
			Observer.setPhaseToShoot()

			#Observer.shootingPhase = false
			#global_position = spawn_point
			#x_movment = SPEED
			#y_movment = 0
			#self.set_rotation_degrees(0)

func _on_area_2d_area_entered(area: Area2D):
	if area.name == "shoot_area" and !area.get_parent().get_parent().get_used():
		# sets the position of the bullet on the gun barrel
		for child in area.get_children():
			if child.name == "barrel":
				self.global_position = child.global_position
		
		var gun_rotation = area.get_parent().get_parent().get_rotation_applied()
		self.set_rotation_degrees(gun_rotation)

		if gun_rotation == 0 :
			set_movment(SPEED, 0)
			
		if gun_rotation == 90 :
			set_movment(0,SPEED)
			
		if gun_rotation == 180 :
			set_movment(-SPEED, 0)
			
		if gun_rotation == 270 :
			set_movment(0, -SPEED)
		area.get_parent().get_parent().set_used_true()
	
	if area.name == "win" :
		pass
	
	if area.name == "cut_area" :
		area.get_parent().get_parent().cut_bullet()


				
func set_movment(x,y):
	y_movment = y
	x_movment = x
