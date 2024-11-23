extends Node2D

const garbage_objects = [
	preload("res://garbage_objects/can.tscn"),
	preload("res://garbage_objects/solo_cup.tscn"),
	preload("res://garbage_objects/bottle.tscn"),
	preload("res://garbage_objects/paper_cup.tscn")
];

var time: int;
func _ready():
	var time = Time.get_ticks_msec();

func _process(_delta):
	if (Time.get_ticks_msec() >= time):
		time += 100;
		var index = randi_range(0, len(garbage_objects)-1);
		var scene = garbage_objects[index].instantiate();
		scene.global_transform = Transform2D(randf_range(0, PI*2), Vector2(randf_range(30, get_window().content_scale_size.x - 30), randf_range(-200, -100)));
		add_child(scene);


func _on_garbage_sleep_area_body_entered(body: Node2D) -> void:
	body.queue_free();
