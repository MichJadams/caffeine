extends Node2D

const drink_names = [
	[
		{
			"minimum_heat": 130,
			"espresso": 0, 
			"name": "cappuccino",
		}
	],
	[
		{
			"minimum_heat": 160,
			"espresso": 0, 
			"name": "Latte",
		}
	]
]
func get_drink_name(input_heat, input_espresso_percentage):
	var selected_drink = {
			"minimum_heat": 0,
			"espresso": 0, 
			"name": "nothing!",
		}
	for heat_level_band in drink_names: 
		for drink in heat_level_band: 
			if input_heat >= drink.minimum_heat and input_espresso_percentage >= drink.espresso:
				selected_drink = drink
	return selected_drink.name

func _on_thermometer_value_changed(heat_level):
	var drink_name = get_drink_name(heat_level, 0)
	print("drink name:", drink_name)
	
