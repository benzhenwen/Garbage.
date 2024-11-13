extends Node2D

const garbage_objects = [
	preload("res://garbage_objects/can.tscn"),
	preload("res://garbage_objects/trash_bag.tscn"),
	preload("res://garbage_objects/paper.tscn"),
	preload("res://garbage_objects/solo_cup.tscn")
];

func _ready():
	for i in range(40):
		var scene = garbage_objects.pick_random().instantiate();
		scene.global_transform.origin = Vector2(randf_range(30, 600), randf_range(300, 600));
		add_child(scene);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
