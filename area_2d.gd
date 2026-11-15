extends Area2D

var levelNum = 1



func _on_body_entered(body: Node2D) -> void:
	levelNum += 1
	get_tree().change_scene_to_file("res://level"+levelNum)

func _ready() -> void:
	if not self.body_entered.is_connected(_on_body_entered):
		self.body_entered.connect(_on_body_entered)
