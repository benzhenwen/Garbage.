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
	"coffee_cup"
]

var trash_count = 40;
func decrement_trash_count() -> bool:
	trash_count -= 1;
	
	if (trash_count == 0):
		%"End Animation".play("end_card_transition");
		
		return true;
	return false;

func _on_end_animation_animation_finished(_anim_name):
	remove_child(%"recycling bin");
	remove_child(%"trash bin");

func _ready():
	for i in range(trash_count):
		var index = randi_range(0, len(garbage_objects)-1);
		var scene = garbage_objects[index].instantiate();
		
		var tx = randf_range(30, 600);
		if (randi_range(0, 1)):
			tx = 1920 - tx;
		
		scene.global_transform = Transform2D(randf_range(0, PI*2), Vector2(tx, randf_range(300, 600)));
		scene.trash_name = garbage_object_names[index];
		
		add_child(scene);

## ONLY ONE OF EACH ITEM VARIANT
#func _ready(): 
	#trash_count = 4;
	#for i in range(trash_count):
		#var index = i;
		#var scene = garbage_objects[index].instantiate();
		#
		#var tx = randf_range(30, 600);
		#if (randi_range(0, 1)):
			#tx = 1920 - tx;
		#
		#scene.global_transform = Transform2D(randf_range(0, PI*2), Vector2(tx, randf_range(300, 600)));
		#scene.trash_name = garbage_object_names[index];
		#
		#add_child(scene);

#func _process(_delta):
	#pass;

## FLOOD VARIANT
#var time: int;
#func _ready():
	#trash_count = 0;
	#var time = Time.get_ticks_msec();
#
#func _process(_delta):
	#if (Time.get_ticks_msec() >= time):
		#time += 100;
		#var index = randi_range(0, len(garbage_objects)-1);
		#var scene = garbage_objects[index].instantiate();
		#scene.global_transform.origin = Vector2(randf_range(30, 1890), randf_range(100, 400));
		#scene.trash_name = garbage_object_names[index];
		#add_child(scene);
