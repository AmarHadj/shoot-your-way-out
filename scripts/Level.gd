extends Node
@onready var player: Node2D = $Player
@onready var next_level_button: Button = $NextLevelButton


func win():
	next_level_button.visible = true

func lose():
	Observer.create_bullet(player.global_position.x, player.global_position.y, 0, 0, 0)
