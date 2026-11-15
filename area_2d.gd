extends Area2D

var levelNum

func _on_body_entered() -> void:
	levelNum += 1

func _ready() -> void:
	if not self.body_entered.is_connected(_on_body_entered):
		self.body_entered.connect(_on_body_entered)
