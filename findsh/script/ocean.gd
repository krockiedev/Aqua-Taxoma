extends Node3D

@onready var ocean_environment: WorldEnvironment = $OceanEnvironment

var environment_tween: Tween

func transition_ocean_depth(target_color: Color, target_end_distance: float, duration: float) -> void:
	if environment_tween and environment_tween.is_running():
		environment_tween.kill()
		
	environment_tween = create_tween()

	environment_tween.set_parallel(true)
	
	environment_tween.tween_property(
		ocean_environment, 
		"environment:fog_light_color", 
		target_color, 
		duration
	).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

	environment_tween.tween_property(
		ocean_environment, 
		"environment:fog_depth_end", 
		target_end_distance, 
		duration
	).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	
	environment_tween.tween_property(
		ocean_environment,
		"environment:background_color",
		target_color,
		duration
	)
