extends Node2D

var screen_size
var day_counter = 0
var daytime : bool = true
var day_length : int = 10
var night_length : int = 15
var day_completion : float 
var light_rotation

var time = 0



@export var seed_button: PackedScene
@export var pot : PackedScene

func _ready():
	for node in get_tree().get_nodes_in_group("rest_places"):
		Global.rest_nodes.append(node)

	screen_size = get_viewport_rect().size
	$DayTimer.set_wait_time(day_length)
	$NightTimer.set_wait_time(night_length)

	$DayTimer.start()
	
	var tween = create_tween()
	tween.tween_property($NightFilter, "color", Color.WHITE, 2)
	$WindowLight.color = Color.html("ffffff")
	
func _physics_process(delta: float) -> void:
	if daytime:
		day_completion = (day_length-$DayTimer.time_left)/day_length
		#I think 47 is the angle range of the viewport
		light_rotation = (day_completion*47)-23.5
		$Light.rotation = -light_rotation*delta
		$Light.energy = 1.01 * sin(PI* day_completion)

	time += 1 * delta
	var current_time = floor(time)
	$TimeLabel.text = "Time: " + str(current_time)

func _on_day_timer_timeout():
	$NightTimer.start()
	daytime = false
	print("🌙 It is now nighttime.")
	$NightFilter.color = Color.WHITE
	var tween = create_tween()
	tween.tween_property($NightFilter, "color", Color.html("#466166"), 3)
	var tween_window = create_tween()
	tween_window.tween_property($WindowLight, "color", Color.html("#273152"), 3)


func _on_night_timer_timeout():
	$DayTimer.start()
	print("☀️  It is now daytime")
	day_counter += 1
	$DayCountLabel.text = "Day: " + str(day_counter)
	daytime = true
	time = 0

	var tween = create_tween()
	tween.tween_property($NightFilter, "color", Color.WHITE, 2)
	var tween_window = create_tween()
	tween_window.tween_property($WindowLight, "color", Color.html("#ffffff"), 3)
	

func _on_tabletop_body_entered(body):
	if body.has_method("drop"):
		body.drop()


func _on_sunflower_pressed():
	var seed_instance = seed_button.instantiate()
	seed_instance.position= get_global_mouse_position() 
	add_child(seed_instance)


func _on_pot_button_pressed() -> void:
	var pot_instance = pot.instantiate()
	pot_instance.position= Vector2(screen_size.x/2,screen_size.y/2)
	add_child(pot_instance)
