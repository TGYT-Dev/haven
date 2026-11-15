extends Area2D

func _on_body_entered(body: Node2D) -> void:
	var current_file = get_tree().current_scene.scene_file_path.get_file()
	
	var current_num = current_file.get_basename().replace("level", "").to_int()
	var next_num = current_num + 1
	
	var next_scene_path = "res://level%d.tscn" % next_num
	
	if ResourceLoader.exists(next_scene_path):
		get_tree().change_scene_to_file(next_scene_path)
	else:
		print("You beat the final level!")

func _ready() -> void:
	if not body_entered.is_connected(_on_body_entered):
		body_entered.connect(_on_body_entered)
