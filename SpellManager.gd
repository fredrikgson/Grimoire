extends Node

var spell_mappings:Dictionary

const spell_keys:Array[String] = [
	"0123",
	"0132",
	"0213",
	"0231",
	"0312",
	"0321",
	"1023",
	"1032",
	"1203",
	"1302",
	"2013",
	"2103",
]
const spell_values:Array[String] = [
	"Flame Strike",
	"Lightning Bolt",
	"Frost Shard",
	"Drain Life",
	"Heal",
	"Focus",
	"Weaken",
	"Bolster",
]

func _ready() -> void:
	create_spell_mappings()

func get_spell(sequence:Array[int]) -> String: # String for now - should prob be complex type later
	var key:String = ""
	for point in sequence:
		key += str(point)
	
	if spell_mappings.has(key):
		return spell_mappings[key]
	
	return "No spell here"
	

func create_spell_mappings() -> void:
	var keys = spell_keys.duplicate(true)
	for spell_value in spell_values:
		var key = keys.pick_random()
		keys.erase(key)
		spell_mappings[key] = spell_value
