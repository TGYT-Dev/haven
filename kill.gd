extends Area2D

func _on_body_entered():
	get_tree().reload_current_scene()

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
