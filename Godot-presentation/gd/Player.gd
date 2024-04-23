extends CharacterBody2D


const SPEED = 150.0
const JUMP_VELOCITY = -400.0
var  start = Vector2(0,0)
@onready var anim = $"Sprite2D/Node2D/SubViewportContainer/SubViewport/OVERWORLDS - Rabbit/AnimationPlayer"
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	start = global_position
func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	if not direction ==0:
		$"Sprite2D/Node2D".scale.x = direction

	move_and_slide()
	if global_position.y > 1300:
		global_position = start
		
	animations()
func animations():
	var current_anim = ""

	
	if is_on_floor() == true:
	
		if velocity.x == 0: 
			current_anim = "idle - loop"
		else:
			current_anim = "walk - loop"
	else:
		if velocity.y < 0:
			current_anim = "jump"
		else:
			current_anim = "fall"

	if not anim.current_animation == current_anim:
		anim.play(current_anim)
