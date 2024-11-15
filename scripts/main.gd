extends Node2D

const garbage_objects = [
	preload("res://garbage_objects/can.tscn"),
	preload("res://garbage_objects/solo_cup.tscn"),
	preload("res://garbage_objects/bottle.tscn"),
	preload("res://garbage_objects/paper_cup.tscn")
];

const garbage_object_names = [
	"can",
	"solo_cup",
	"glass_bottle",
	"paper_cup"
]

var trash_count = 40;
func decrement_trash_count() -> bool:
	trash_count -= 1;
	return trash_count == 0;

func _ready():
	for i in range(trash_count):
		var index = randi_range(0, len(garbage_objects)-1);
		var scene = garbage_objects[index].instantiate();
		scene.global_transform.origin = Vector2(randf_range(30, 600), randf_range(300, 600));
		scene.trash_name = garbage_object_names[index];
		add_child(scene);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass
	
