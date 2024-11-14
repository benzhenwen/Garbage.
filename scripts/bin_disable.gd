extends Node

func _ready():
	pass

func _process(delta):
	pass

func _on_garbage_sleep_area_body_entered(body: Node2D) -> void:
	if (body.is_in_group("trash")):
		body.process_mode = 4;
		body.hide();
	
	get_node("%End Card").increment_item(name, body.trash_name);
