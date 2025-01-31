extends Node
@onready var player: Node2D = $Player
@onready var next_level_button: Button = $NextLevelButton
@export var bullet_rotation: float
@export var thank_you : Sprite2D

func win():
	if self.name != "level_5":
		next_level_button.visible = true
	else :
		thank_you.set_visible(true)

func lose():
	Observer.create_bullet(player.global_position.x, player.global_position.y, bullet_rotation, 0, 0)
