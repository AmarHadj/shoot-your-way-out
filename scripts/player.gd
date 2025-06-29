extends Node2D
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var sfx_shoot: AudioStreamPlayer2D = $SFX_shoot

var is_shooting

func _process(delta):
	if animated_sprite_2d.is_playing() and is_shooting:
		if animated_sprite_2d.get_frame() == 1 :
			Observer.set_phase_to_shoot()
			sfx_shoot.play()
			is_shooting = false

func shoot_animation():
	animated_sprite_2d.play("Shoot")
	is_shooting = true
