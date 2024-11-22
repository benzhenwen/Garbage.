extends RichTextLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	scale = get_viewport_rect().size / Vector2(1920, 1080);
	
	self_modulate = Color(1, 1, 1, 0.5);

func _on_meta_hover_started(meta: Variant) -> void:
	self_modulate = Color(1, 1, 1, 0.9);

func _on_meta_hover_ended(meta: Variant) -> void:
	self_modulate = Color(1, 1, 1, 0.5);


func _on_meta_clicked(meta: Variant) -> void:
	get_tree().change_scene_to_file("res://scenes/main.tscn");
