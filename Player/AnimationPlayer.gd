extends AnimationPlayer

var walking = false
var idling = false
var jumping = false

func set_jump(animation_tree):
	animation_tree["parameters/conditions/is_walking"] = false
	animation_tree["parameters/conditions/is_idling"] = false
	animation_tree["parameters/conditions/is_jumping"] = true
	animation_tree.set("parameters/Jump/blend_position", 0)


func _on_player_animate(direction, velocity, animation_tree):
	if direction != 0:
		get_parent().scale.x = direction
	animation_tree.set("parameters/Idle/blend_position", direction)
	
	if velocity.x != 0:
		animation_tree["parameters/conditions/is_walking"] = true
		animation_tree["parameters/conditions/is_idling"] = false
		animation_tree["parameters/conditions/is_jumping"] = false
		animation_tree.set("parameters/Walk/blend_position", direction)
		if velocity.y != 0:
			set_jump(animation_tree)
	else:
		animation_tree["parameters/conditions/is_walking"] = false
		animation_tree["parameters/conditions/is_idling"] = true
		animation_tree["parameters/conditions/is_jumping"] = false
		if velocity.y != 0:
			set_jump(animation_tree)
	
#	print(animation_tree["parameters/conditions/is_walking"])
	
#	if Input.is_action_just_pressed("jump"):
#		play("walk_to_jump")
#		await animation_finished
#
#	if direction != 0:
#		get_parent().scale.x = direction
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
	
