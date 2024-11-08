extends Node2D
class_name RuneIconFlasher

@onready var sprite:Sprite2D = $Sprite2D
@onready var spell_name_label:Label = $Text/Label
@onready var anim:AnimationPlayer = $AnimationPlayer

func flash_spell(spell:Spell):
	spell_name_label.text = spell.name
	sprite.texture = spell.icon
	anim.play("flash")
