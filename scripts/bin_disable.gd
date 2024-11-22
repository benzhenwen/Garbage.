extends Node

func _ready():
	pass

func _process(_delta):
	pass

func _on_garbage_sleep_area_body_entered(body: Node2D):
	if (body.is_in_group("trash")):
		body.queue_free();
	
	%"end label".increment_item(name, body.trash_name);
