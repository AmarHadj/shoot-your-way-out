extends Button

@onready var level: Node2D = $"."


func _on_pressed() -> void:
	print(level.name)
