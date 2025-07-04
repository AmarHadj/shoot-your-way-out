extends Node
@onready var player: Node2D = $Player
@onready var next_level_button: Button = $NextLevelButton
@export var bullet_rotation: float
@export var thank_you : Sprite2D
@onready var music_handler: Node2D = $music_handler
var change_music = true

func _ready() -> void:
	music_handler.play_ambiance_music()
	
func _process(delta: float) -> void:
	if Observer.shootingPhase and change_music:
		music_handler.stop_ambiance_music()
		music_handler.play_shooting_music()
		change_music = false
		
		
func win():
	music_handler.stop_shooting_music()
	music_handler.play_win_music()
	change_music = true
	if self.name != "level_9":
		next_level_button.visible = true
	else :
		thank_you.set_visible(true)

func lose():
	music_handler.stop_shooting_music()
	music_handler.play_lose_music()
	change_music = true
	Observer.create_bullet(player.global_position.x, player.global_position.y, bullet_rotation, 0, 0)
