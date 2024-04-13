extends Node2D
class_name PlantScene

var plant_seed:Plant
var plant
var planted:bool =false
var current_growth:int = 0
var max_growth:int

var plant_name:String
var scene:PackedScene
var stages:int
var thirst:float
var happiness:float


func show_seed():
	var seed = plant_seed.scene.instantiate()
	seed.name=plant_seed.plant_name
	add_child(seed)
	plant = seed
	plant.propagate_call("set_visible", [false])
	plant.visible=true
	plant.find_child("seed").show()
	return plant

func _process(_delta: float) -> void:
	pass
	
func on_ground():
	plant_name = plant_seed.plant_name
	scene = plant_seed.scene
	max_growth = plant_seed.stages
	thirst = 1
	happiness = 1
	current_growth = 0
	planted = true
	grow()


func grow():
	if current_growth == max_growth:
		return "AlreadyGrown"
	if current_growth == 0:
		await get_tree().create_timer(3).timeout
		plant.find_child("seed").hide()
		plant.find_child("growth_01").show()
		current_growth += 1
		print_debug(plant.find_child("growth_01").name)
 
