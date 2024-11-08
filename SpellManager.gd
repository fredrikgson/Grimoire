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
const spell_values:Array[Spell] = [
	preload("res://resources/spells/Bolster.tres"),
	preload("res://resources/spells/DrainLife.tres"),
	preload("res://resources/spells/FlameStrike.tres"),
	preload("res://resources/spells/Focus.tres"),
	preload("res://resources/spells/FrostShard.tres"),
	preload("res://resources/spells/Heal.tres"),
	preload("res://resources/spells/LightningBolt.tres"),
	preload("res://resources/spells/Weaken.tres"),
]
const spark_spell:Spell = preload("res://resources/spells/Spark.tres")

func _ready() -> void:
	create_spell_mappings()

func get_spell(sequence:Array[int]) -> Spell: # String for now - should prob be complex type later
	if len(sequence) < 4:
		return spark_spell
	
	var key:String = ""
	for point in sequence:
		key += str(point)
	
	if not spell_mappings.has(key):
		return spark_spell
	
	return spell_mappings[key]
	

func create_spell_mappings() -> void:
	var keys = spell_keys.duplicate(true)
	for spell_value in spell_values:
		var key = keys.pick_random()
		keys.erase(key)
		spell_mappings[key] = spell_value
