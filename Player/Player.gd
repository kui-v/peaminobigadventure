extends CharacterBody2D

const SPEED = 50
const GRAVITY = 20
const JUMP_VELOCITY = 200
const CLIMB_SLOW = 50
var direction = 1

@onready var animation_tree : AnimationTree = $Animations/AnimationTree

signal animate

var noclip = false

func _ready():
	animation_tree.active = true

func eval_noclip():
	if Input.is_action_just_pressed("noclip"):
		noclip = !noclip

func _physics_process(_delta):
	eval_noclip()
	if noclip:
		velocity = Input.get_vector("left", "right", "up", "down") * 100
	else:
		direction = Input.get_axis("left", "right")
		apply_animation(direction)
		apply_gravity()
		jump()
		move(direction)
		climb_corner(direction)
	move_and_slide()

func apply_animation(direction):
	emit_signal("animate", direction, velocity, animation_tree)

func apply_gravity():
	if not is_on_floor():
		velocity.y += GRAVITY

func move(direction):
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

func jump():
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y -= JUMP_VELOCITY

func climb_corner(direction):	
	$CollisionShape2D/EdgeDetectionY.set_target_position(Vector2(0, direction * -5))
	if !$CollisionShape2D/EdgeDetectionY.is_colliding() && is_on_wall() && !is_on_floor():
#		velocity.x = direction * 1
		position = position + Vector2(direction,-1)
		print(velocity.y)
		print("climbing")
