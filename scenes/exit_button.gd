extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	modulate = Color(1,1,1,0.3);


func _on_mouse_entered() -> void:
	modulate = Color(1,1,1,0.7);


func _on_mouse_exited() -> void:
	modulate = Color(1,1,1,0.3);


func _on_pressed() -> void:
	get_tree().quit();
