extends Node2D

const drink_names = [
	[
		{
			"minimum_heat": 130,
			"espresso": 0, 
			"name": "cappuccino",
		},
		{
			"minimum_heat": 0,
			"espresso": 98, 
			"name": "Shot of Espresso",
		}
	],
	[
		{
			"minimum_heat": 140,
			"espresso": 70, 
			"name": "macchiato",
		}
	],
	[ 
		{
			"minimum_heat": 160,
			"espresso": 0, 
			"name": "Latte",
		},
		{
			"minimum_heat": 0,
			"espresso": 98, 
			"name": "Shot of Espresso",
		}
	]
]
var selected_drink = {
			"minimum_heat": 0,
			"espresso": 0, 
			"name": "nothing!",
		}
		
func get_drink_name():
	var coffe_slider = $mug/CoffeeMask/CoffeSlider
	var thermometer = $Thermometer/Thermometer
	var input_heat = thermometer.value
	var input_espresso_percentage = coffe_slider.value
	
	print("input heat:", input_heat, "input_espresso", input_espresso_percentage)
	
	for heat_level_band in drink_names: 
		for drink in heat_level_band: 
			if input_heat >= drink.minimum_heat and input_espresso_percentage >= drink.espresso:
				selected_drink = drink
	return selected_drink.name

func update_drink():
	var drink_name = get_drink_name()
	print("heat", selected_drink.minimum_heat, "espresso: ", selected_drink.espresso, "name:", selected_drink.name)
	$Label/DrinkName.text = selected_drink.name

func _on_thermometer_value_changed(heat_level):
	update_drink()
	
func _on_coffe_slider_value_changed(value):
	update_drink()

