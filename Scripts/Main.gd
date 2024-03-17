extends Node2D

var screen_size
var day_counter= 1
var daytime = true
var day_length = 10
var night_length = 15
var day_completion
var light_rotation

var time = 0

@export var pot : PackedScene

func _ready():
	screen_size = get_viewport_rect().size
	$DayTimer.set_wait_time(day_length)
	$DayTimer.start()
	var pot_instance = pot.instantiate()
	pot_instance.position= Vector2(randi_range(0,screen_size.x),randi_range(0,screen_size.y))
	add_child(pot_instance)
	var tween = create_tween()
	tween.tween_property($NightFilter, "color", Color.WHITE, 2)
	$WindowLight.color = Color.html("ffffff")
	
func _process(delta):
	if daytime:
		day_completion = (day_length-$DayTimer.time_left)/day_length
		light_rotation = (day_completion*47)-23.5
		$Light.rotation = -light_rotation*delta
		$Light.energy = 1.01 * sin(PI* day_completion)
	#else:
		##HSL 195 28 80
		#pass
		
	time += 1 * delta
	var current_time = floor(time)
	$TimeLabel.text = "Time: " + str(current_time)
	$TimeLabel.show()



func _on_button_pressed():
	var pot_instance = pot.instantiate()
	pot_instance.position= Vector2(randi_range(0,screen_size.x),randi_range(0,screen_size.y))
	add_child(pot_instance)


func _on_day_timer_timeout():
	$NightTimer.set_wait_time(night_length)
	$NightTimer.start()
	daytime = false
	print("It is now nighttime.")
	$NightFilter.color = Color.WHITE
	var tween = create_tween()
	tween.tween_property($NightFilter, "color", Color.html("#466166"), 3)
	var tween_window = create_tween()
	tween_window.tween_property($WindowLight, "color", Color.html("#273152"), 3)


func _on_night_timer_timeout():
	$DayTimer.set_wait_time(day_length)
	$DayTimer.start()
	print("It is now daytime")
	day_counter += 1
	$DayCountLabel.text = "Day: " + str(day_counter)
	$DayCountLabel.show()
	daytime = true
	time = 0
	var tween = create_tween()
	tween.tween_property($NightFilter, "color", Color.WHITE, 2)
	var tween_window = create_tween()
	tween_window.tween_property($WindowLight, "color", Color.html("#ffffff"), 3)
	
