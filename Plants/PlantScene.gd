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
	plant = plant_seed.scene.instantiate()
	add_child(plant)
	# plant.name = plant_seed.plant_name
	plant.propagate_call("set_visible", [false])
	plant.call_deferred("set_visible",[true])
	$Plant/seed.propagate_call("set_visible",[true])

	
var count = 0
func _process(delta: float) -> void:
	if planted:
		count += delta
	if count >= 2 and planted:
		if current_growth < max_growth:
			grow()
			count = 0
	
func on_ground():
	plant_name = plant_seed.plant_name
	scene = plant_seed.scene
	max_growth = plant_seed.stages
	thirst = 1
	happiness = 1
	current_growth = 0
	planted = true
	await get_tree().create_timer(1).timeout
	grow()


func grow():
	if current_growth == max_growth:
		# print("AlreadyGrown")
		return
	if current_growth == 0:
		$Plant/seed.hide()
		$Plant/growth_01.propagate_call("set_visible",[true])
		current_growth += 1
		return
	if current_growth == 1:
		$Plant/growth_01.hide()
		$Plant/growth_02.propagate_call("set_visible",[true])
		current_growth += 1
		return
	if current_growth == 2:
		$Plant/growth_02.hide()
		$Plant/growth_03.propagate_call("set_visible",[true])
		current_growth += 1
		return
	if current_growth == 3:
		$Plant/growth_03.hide()
		$Plant/growth_04.propagate_call("set_visible",[true])
		current_growth += 1
		return
	if current_growth == 4:
		$Plant/growth_04.hide()
		$Plant/growth_05.propagate_call("set_visible",[true])
		current_growth += 1
		return
 
