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
	if held:
		var new_position = get_global_mouse_position() + mouse_offset
		new_position = new_position.clamp(Vector2.ZERO, screen_size)
		move_and_collide(new_position - global_transform.origin)
		
		freeze = true
		if Input.is_action_just_pressed("mouse_left") or\
				Input.is_action_just_pressed("mouse_right"):
				held = false
				freeze =false
				# velocity = 0
				# $CollisionShape2D.disabled=false
				# $pot_picked.visible = false
				# $pot_onfloor.visible = true
		
	elif on_area && Input.is_action_just_pressed("mouse_left"):
			held = true
			mouse_offset = global_transform.origin - get_global_mouse_position()
			# $CollisionShape2D.disabled=false #we use move and collide kasi
			# $pot_picked.visible = true #tmp
			# $pot_onfloor.visible = false #temp
			# $pot_picked2.play()

	
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
