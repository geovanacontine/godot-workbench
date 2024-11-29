extends BoxContainer

@export var component: HealthComponent

func _on_damage_button_pressed() -> void:
	component.damage(25)

func _on_heal_button_pressed() -> void:
	component.heal(40)
