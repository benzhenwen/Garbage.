extends Area2D

func _ready():
	pass 

func _process(delta):
	pass


func _on_body_entered(body):
	if (body.is_in_group("trash")):
		body.process_mode = 4;
		body.hide();
