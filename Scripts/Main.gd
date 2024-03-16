extends Node2D

var screen_size

@export var pot : PackedScene

func _ready():
	screen_size = get_viewport_rect().size
	pass
	
func _process(delta):
	pass
	


func _on_button_pressed():
	var pot_instance = pot.instantiate()
	pot_instance.position= Vector2(randi_range(0,screen_size.x),randi_range(0,screen_size.y))
	add_child(pot_instance)
