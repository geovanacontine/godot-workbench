extends Node
class_name HealthComponent

signal died
signal healed(amount)
signal damaged(amount)

@export_group("Properties")
@export var max_life: int

var min_life: int = 0
var current_life: int

func _ready() -> void:
	current_life = max_life

func heal(amount: int):
	var new_life = current_life + amount
	current_life = clamp(new_life, min_life, max_life)
	healed.emit(amount)

func damage(amount: int):
	var new_life = current_life - amount
	current_life = clamp(new_life, min_life, max_life)
	damaged.emit(amount)
	
	if current_life <= 0:
		died.emit()
