extends Node2D
@onready var ambiance_music: AudioStreamPlayer2D = $Ambiance_music
@onready var shooting_music: AudioStreamPlayer2D = $Shooting_music
@onready var lose_music: AudioStreamPlayer2D = $lose_music
@onready var win_music: AudioStreamPlayer2D = $win_music

func play_ambiance_music():
	ambiance_music.play()

func stop_ambiance_music():
	ambiance_music.stop()
	
func play_shooting_music():
	shooting_music.play()
	
func stop_shooting_music():
	shooting_music.stop()
	
func play_lose_music():
	lose_music.play()
	
func play_win_music():
	win_music.play()
	
func _on_lose_music_finished() -> void:
	ambiance_music.play()
