extends RichTextLabel

func _ready():
	scale = Vector2(
		get_window().content_scale_size.x / 1920,
		get_window().content_scale_size.y / 1080
	);

func _process(_delta):
	pass;
	
var item_map = {
	"recycling bin": {
		"can": 0,
		"solo_cup": 0,
		"glass_bottle": 0,
		"coffee_cup": 0
	},
	"trash bin": {
		"can": 0,
		"solo_cup": 0,
		"glass_bottle": 0,
		"coffee_cup": 0
	}
}

func increment_item(from: String, item: String):
	item_map[from][item] += 1;
	print(from + " -> " + item + ": " + str(item_map[from][item]));
	if (get_parent().get_parent().decrement_trash_count()):
		trigger_end_scene();

func trigger_end_scene():
	get_parent().call_deferred("add_child", load("res://scenes/ending_physics_scene.tscn").instantiate());
	
	print("end");
	
	# map of what items had what decisions made
	var had_recycled = {
		"can": item_map["recycling bin"]["can"] > item_map["trash bin"]["can"],
		"solo_cup": item_map["recycling bin"]["solo_cup"] > item_map["trash bin"]["solo_cup"],
		"glass_bottle": item_map["recycling bin"]["glass_bottle"] > item_map["trash bin"]["glass_bottle"],
		"coffee_cup": item_map["recycling bin"]["coffee_cup"] > item_map["trash bin"]["coffee_cup"],
	}
	
	text =  "			How much did you think about the decisions you made?\n" \
		+ "\n" \
		+ "\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["can"] else "trash") + " aluminum cans.\n" \
		+ "Aluminum cans should be recycled, but make sure to empty them first, and don't crush them.\n" \
		+ "If liquid is left inside or the can is crushed it might not be recycled.\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["solo_cup"] else "trash") + " red solo cups.\n" \
		+ "These cups are #6 plastic, and " + ("usually can't" if had_recycled["solo_cup"] else "sometimes can") + " be recycled.\n" \
		+ "Check with your local recycling plant to see if you can.\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["glass_bottle"] else "trash") + " glass bottles.\n" \
		+ "Glass should be recycled, and sometimes has a dedicated dropoff location.\n" \
		+ "In some cases, improperly sorting glass can cause slag to form in plants.\n" \
		+ "Check with your local recycling plant :)\n" \
		+ "\n" \
		+ "You decided to " + ("recycle" if had_recycled["coffee_cup"] else "trash") + " coffee cups.\n" \
		+ "Especially from coffee shops, these cups " + ("are trash" if had_recycled["solo_cup"] else "should be trashed") + ", despite being made of paper.\n" \
		+ "This is because they are commonly lined with non-recyclable plastic.\n" \
		+ "\n" \
		+ "\n" \
		+ "\n" \
		+ "\n" \
		+ "More Info:\n" \
		+ "[url=https://keepmassbeautiful.org/news-events/the-kmb-blog/overview.html/article/2021/01/30/aluminum-cans-are-champions-of-the-environment-are-you-recycling-them-properly-][color=sky_blue]Aluminum Cans[/color][/url], \
[url=https://racetozerowaste.org/ditch6-say-goodbye-to-6-plastics/][color=sky_blue]Solo Cups[/color][/url], \
[url=https://www.tricorbraun.com/blog/glass-recycling-what-you-need-to-know.html][color=sky_blue]Glass[/color][/url], \
[url=https://foodprint.org/blog/environmental-impact-coffee-cup/][color=sky_blue]Coffee Cups[/color][/url]" \
		;



func _on_meta_clicked(meta):
	OS.shell_open(str(meta));
