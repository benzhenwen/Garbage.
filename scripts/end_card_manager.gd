extends Node2D

var item_map = {
	"recycling bin": {
		"can": 0,
		"solo_cup": 0
	},
	"trash bin": {
		"can": 0,
		"solo_cup": 0
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func increment_item(from: String, item: String):
	item_map[from][item] += 1;
	print(from + " -> " + item + ": " + str(item_map[from][item]));
	if (get_parent().decrement_trash_count()):
		_trigger_end_sequence();

func _trigger_end_sequence():
	print("end");
	
	# map of what items had what decisions made
	var had_recycled = {
		"can": "recycle" if (item_map["recycling bin"]["can"] > item_map["trash bin"]["can"]) else "trash",
		"solo_cup": "recycle" if (item_map["recycling bin"]["solo_cup"] > item_map["trash bin"]["solo_cup"]) else "trash"
	}
	
	get_node("%label_solo_cup").text = "You decided to " + had_recycled["solo_cup"] + " red solo cups\n";
