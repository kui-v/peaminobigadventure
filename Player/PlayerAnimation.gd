#extends AnimatedSprite2D
#
#var walking = false
#var idling = false
#
#func _on_player_animate(direction, velocity):
#	if direction < 0 :
#		set_flip_h(true)
#		if idling:
#			play("idle_to_walk")
#			await animation_finished
#			idling = false		
#		play("walk")
#		walking = true
#	elif direction > 0:
#		set_flip_h(false)
#		if idling:
#			play("idle_to_walk")
#			await animation_finished
#			idling = false
#		play("walk")
#		walking = true
#	else:
#		if walking:
#			play("walk_to_idle")
#			await animation_finished
#			walking = false
#		play("idle")
#		idling = true
