extends RigidBody2D
class_name Seed

var screen_size
var on_area
var held = true
var mouse_pressed = false
var left_click_count= 0
var mouse_offset = Vector2.ZERO
var seed_instance
@export var plant_seed:Plant
var IMPLEMENTS= "Plantable"

func _ready():
	seed_instance = PlantScene.new()
	seed_instance.plant_seed = plant_seed
	seed_instance.show_seed()
	add_child(seed_instance)
	
	contact_monitor= true
	screen_size= get_viewport_rect().size

func _process(_delta):
	if on_area && Input.is_action_just_pressed("mouse_left"):
		if held:
			held =false
			#$pot_picked.visible = false
		else:
			held = true
			mouse_offset = global_transform.origin - get_global_mouse_position()
			#$pot_picked.visible = true
			#$pot_picked2.play()
	if Input.is_action_just_pressed("mouse_right"):
		#$pot_picked.visible = false
		held = false

	if held:
		var new_position = get_global_mouse_position() + mouse_offset
		new_position = new_position.clamp(Vector2.ZERO, screen_size)
		global_transform.origin = new_position
	
func drop():
	print("🌱seed dropped on the floor")
	#$seed_dropped.play()

func absorb():
	queue_free()

func _on_area_2d_mouse_entered():
	on_area = true
	set_modulate("#cdcdcd")
	
func _on_area_2d_mouse_exited():
	set_modulate("#ffffff")
	on_area = false
