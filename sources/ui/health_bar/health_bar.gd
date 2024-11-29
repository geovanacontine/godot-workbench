extends Control
class_name HealthBar

@export_group("Target")
@export var component: HealthComponent

@export_group("Style")
@export var life_color: Color
@export var damage_color: Color
@export var heal_color: Color

@export_group("Animation")
@export var damage_delay: float = 0.3
@export var heal_delay: float = 0.3

@onready var life_bar: ProgressBar = $Container/Background/LifeBar
@onready var feedback_bar: ProgressBar = $Container/Background/FeedbackBar

func _ready() -> void:
	setup_bar_color(life_bar, life_color)
	setup_signals()
	setup_bars()

func damage_animation(_amount: int):
	setup_bar_color(feedback_bar, damage_color)
	life_bar.value = component.current_life
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC) 
	tween.tween_property(feedback_bar, "value", life_bar.value, damage_delay)

func heal_animation(_amount: int):
	setup_bar_color(feedback_bar, heal_color)
	feedback_bar.value = component.current_life
	var tween = create_tween()
	tween.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC) 
	tween.tween_property(life_bar, "value", feedback_bar.value, heal_delay)

func die_animation():
	pass

func setup_signals():
	component.damaged.connect(damage_animation)
	component.healed.connect(heal_animation)
	component.died.connect(die_animation)

func setup_bars():
	life_bar.value = component.current_life
	life_bar.max_value = component.max_life
	feedback_bar.value = component.current_life
	feedback_bar.max_value = component.max_life

func setup_bar_color(bar: ProgressBar, color: Color):
	var new_style = bar.get_theme_stylebox("fill").duplicate()
	new_style.bg_color = color
	bar.add_theme_stylebox_override("fill", new_style)
