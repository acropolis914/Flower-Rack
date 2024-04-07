extends RigidBody2D

var screen_size
var on_area : bool
var held : bool = false
var mouse_pressed = false
var mouse_offset
var has_seed : bool = false
#const SPRING_CONSTANT := 100.0
#func _physics_process(delta):
	#if Input.is_action_pressed("mouse"):
		#apply_central_impulse(SPRING_CONSTANT * get_local_mouse_position() * delta)

func _ready():
	$pot_picked.visible = false
	screen_size= get_viewport_rect().size

var previous_velocity = 0
var previous_wiggle = 0.0
func _process(delta):
	var velocity = Input.get_last_mouse_velocity()
	var wiggle = deg_to_rad(velocity.y - previous_velocity/800)*delta
	#print(wiggle)
	previous_velocity = velocity.y
	if on_area && Input.is_action_just_pressed("mouse_left"):
		if held:
			held =false
			$CollisionShape2D.disabled=false
			$pot_picked.visible = false
			$TextureRect.visible = true
		else:
			held = true
			mouse_offset = global_transform.origin - get_global_mouse_position()
			$CollisionShape2D.disabled=true
			$pot_picked.visible = false #tmp
			$TextureRect.visible = true #temp
			$pot_picked2.play()
	if Input.is_action_just_pressed("mouse_right"):
		$CollisionShape2D.disabled=false
		$pot_picked.visible = false
		$TextureRect.visible = true
		held = false
		
	if held:
		var new_position = get_global_mouse_position() + mouse_offset
		new_position = new_position.clamp(Vector2.ZERO, screen_size)
		global_transform.origin = new_position
		rotation = lerp(0.0,wiggle,.5)
		previous_wiggle = wiggle
		
func _physics_process(_delta):
	pass
	
func drop():
	$pot_dropped.play()

func _on_mouse_entered():
	on_area = true
	$TextureRect.set_modulate("#cdcdcd")

func _on_mouse_exited():
	$TextureRect.set_modulate("#ffffff")
	on_area = false

func _on_body_entered(body):
	if body is Seed && has_seed:
		print("🪴Pot already has seed")
		return 
	if body is Seed && !body.held:
		catch_seed(body.plant_seed)
		has_seed = true
		body.absorb()
		$absorb_particles.emitting = true
		print($absorb_particles.emitting)

		
	#var plant_type = body.plant_type # Assuming the seed has a property indicating its plant type
	#var plant_scene_path = plant_scenes[plant_type]
	#var plant_scene = load(plant_scene_path)
	#var plant_instance = plant_scene.instance()
	#add_child(plant_instance)
	
func catch_seed(plant_seed:Plant):
	print("Picked up " + plant_seed.plant_name)
	
