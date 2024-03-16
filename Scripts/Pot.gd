extends RigidBody2D

var screen_size
var on_area
var held = false
var mouse_pressed = false
var left_click_count= 0
var mouse_offset
#const SPRING_CONSTANT := 100.0
#func _physics_process(delta):
	#if Input.is_action_pressed("mouse"):
		#apply_central_impulse(SPRING_CONSTANT * get_local_mouse_position() * delta)

func _ready():
	screen_size= get_viewport_rect().size

func _process(delta):
	if Input.is_action_just_pressed("mouse_left"):
		if not on_area:
			return
		else:
			if held:
				held =false
				$CollisionShape2D.disabled=false
			else:
				held = true
				mouse_offset = global_transform.origin - get_global_mouse_position()
				$CollisionShape2D.disabled=true
	if Input.is_action_just_pressed("mouse_right"):
		$CollisionShape2D.disabled=false
		held = false
	if held:
		global_transform.origin = get_global_mouse_position() + mouse_offset
	

	
func _physics_process(delta):
	pass

func _on_mouse_entered():
	on_area = true
	$TextureRect.set_modulate("#cdcdcd")

 
func _on_texture_rect_mouse_exited():
	$TextureRect.set_modulate("#ffffff")
	on_area = false
	

