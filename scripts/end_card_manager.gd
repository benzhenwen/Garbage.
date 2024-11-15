extends Node2D

var item_map = {
	"recycling bin": {
		"can": 0,
		"solo_cup": 0,
		"glass_bottle": 0,
		"paper_cup": 0
	},
	"trash bin": {
		"can": 0,
		"solo_cup": 0,
		"glass_bottle": 0,
		"paper_cup": 0
	}
}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
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
		"can": item_map["recycling bin"]["can"] > item_map["trash bin"]["can"],
		"solo_cup": item_map["recycling bin"]["solo_cup"] > item_map["trash bin"]["solo_cup"],
		"glass_bottle": item_map["recycling bin"]["glass_bottle"] > item_map["trash bin"]["glass_bottle"],
		"paper_cup": item_map["recycling bin"]["paper_cup"] > item_map["trash bin"]["paper_cup"],
	}
	
	get_node("%label_body_text").text = "" \
		+ "You decided to " + ("recycle" if had_recycled["can"] else "trash") + " aluminum cans.\n" \
		+ "Aluminum cans should be recycled, but make sure to empty them first.\n" \
		+ "If liquid is left inside the can it will not be recycled.\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["solo_cup"] else "trash") + " red solo cups.\n" \
		+ "These cups are #6 plastic, and " + ("usually can't" if had_recycled["solo_cup"] else "sometimes can") + " be recycled.\n" \
		+ "Check with your local recycling plant to see if you can.\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["glass_bottle"] else "trash") + " glass bottles.\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["paper_cup"] else "trash") + " paper coffee cups.\n" \
		;
