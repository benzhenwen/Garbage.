extends RigidBody2D

var last_lmb_state: bool = false;

var mouse_overlaps: bool = false;
var is_held: bool = false;

var hold_offset: Vector2 = Vector2(0, 0);

var trash_name: String;

# Called when the node enters the scene tree for the first time.
func _ready():
	contact_monitor = true;
	max_contacts_reported = 9999;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_mouse_button_pressed(1):
		if (not is_held) and mouse_overlaps and (not last_lmb_state):
			hold_offset = rotate_point(get_viewport().get_mouse_position() - get_position(), -get_transform().get_rotation());
			is_held = true;
	else:
		if (is_held):
			is_held = false;
	
	last_lmb_state = Input.is_mouse_button_pressed(1);

func rotate_point(point: Vector2, angle: float): 
	return Vector2(
		point.x*cos(angle)-point.y*sin(angle),
		point.x*sin(angle)+point.y*cos(angle)
	);

func _integrate_forces(state):
	if (is_held):
		var force = (get_viewport().get_mouse_position()-(get_position()+0.5*rotate_point(hold_offset, get_transform().get_rotation())))*1*pow(get_position().distance_to(get_viewport().get_mouse_position()), 2);
		if force.length() > 80000:
			force = force.normalized() * 80000;
		apply_force(force, rotate_point(hold_offset, get_transform().get_rotation()));
	
		linear_velocity *= 0.9;
		angular_velocity *= 0.85;
		
		if linear_velocity.length() > 300:
			linear_velocity = linear_velocity.normalized() * 300;
		
		var panicking = false;
		if angular_velocity > 4:
			angular_velocity = 4;
			panicking = true;
		if angular_velocity < -4:
			angular_velocity = -4;
			panicking = true;
		
		if panicking and get_position().distance_to(get_viewport().get_mouse_position()) > 35:
			angular_velocity *= 0.15;

func _on_mouse_entered():
	mouse_overlaps = true;
func _on_mouse_exited():
	mouse_overlaps = false;
