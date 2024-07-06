extends Node2D

var all_drinks = []

func get_drink():
	var coffe_slider = $mug/CoffeeMask/CoffeSlider
	var thermometer = $Thermometer/Thermometer
	var input_heat = thermometer.value
	var input_espresso_percentage = coffe_slider.value
	
	print("input heat: ", input_heat, " input_espresso: ", input_espresso_percentage)
	
	var chosen = all_drinks.back() # milk
	
	# find closest espresso
	for drink in all_drinks:
		if input_espresso_percentage >= drink.minimum_espresso:
			print("espresso candidate: ", drink)
			if input_espresso_percentage - drink.minimum_espresso < input_espresso_percentage - chosen.minimum_espresso :
				print(drink, " better than ", chosen)
				chosen = drink
	# find closest temp
	for drink in all_drinks:
		if input_heat >= drink.minimum_heat and drink.minimum_espresso == chosen.minimum_espresso:
			print("heat candidate: ", drink)
			if input_heat - drink.minimum_heat < input_heat - chosen.minimum_heat:
				print(drink, " better than ", chosen)
				chosen = drink
	
	return chosen

func update_drink():
	var drink = get_drink()
	print("selected: ", drink)
	$Label/DrinkName.text = drink.name
	
	# input labels
	var coffe_slider = $mug/CoffeeMask/CoffeSlider
	var thermometer = $Thermometer/Thermometer
	var input_heat = thermometer.value
	var input_espresso_percentage = coffe_slider.value
	$TemperatureLabel/DrinkName.text = str(input_heat) + "°"
	$PercentageLabel/DrinkName.text = str(input_espresso_percentage) + "%"
	
	# steam
	var percent = remap(thermometer.value, 100, 250, 0, 1)
	# print(percent)
	$mug/Steam.amount_ratio = percent

func _on_thermometer_value_changed(heat_level):
	update_drink()
	
func _on_coffe_slider_value_changed(value):
	update_drink()

class Drink:
	var name
	var minimum_heat
	var minimum_espresso
	
	func _init(name_: String, min_heat: int, min_esp: int):
		name = name_
		minimum_heat = min_heat
		minimum_espresso = min_esp
		
	func _to_string():
		return name + ": " + str(minimum_heat) + "/" + str(minimum_espresso)

func load_coffee_data():
	var file = FileAccess.open("res://data.csv", FileAccess.READ)
	
	# skip headers
	file.get_csv_line()

	var line = file.get_csv_line()
	while line.size() > 1:
		all_drinks.append(Drink.new(line[0], int(line[1]), int(line[2])))
		line = file.get_csv_line()

	all_drinks.append(Drink.new("Warm Milk", 0, 0))
	for drink in all_drinks:
		print(drink)

func _ready():
	load_coffee_data()
