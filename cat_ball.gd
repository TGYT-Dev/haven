extends CharacterBody2D

const SPEED = 300.0
const AIR_SPEED = 250.0
const AIR_ACCEL = 10.0
const JUMP_VELOCITY = -400.0
const BOUNCE_DAMPENING = 0.75 # Adjust how bouncy it is (1.0 = full bounce)

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_grounded = false

func _physics_process(delta):
	
	if is_zero_approx(velocity.y):
		velocity.y = 0 
	
	# 1. Apply gravity if not on the ground
	if not is_grounded:
		velocity.y += gravity * delta
	else:
		# Apply a bit of friction when resting on the floor
		velocity.x = move_toward(velocity.x, 0, SPEED * 0.2)

	# 2. Handle jump when grounded
	if Input.is_action_just_pressed("ui_accept") and abs(velocity.y) < 80:
		velocity.y = JUMP_VELOCITY
		is_grounded = false

	# 3. Handle horizontal input movement
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		if is_grounded:
			velocity.x = direction * SPEED
		else:
			# Air control: steer toward target speed instead of snapping to it
			velocity.x = move_toward(velocity.x, direction * AIR_SPEED, AIR_ACCEL)

	# 4. Use move_and_collide for strict collision and immediate bouncing
	var collision = move_and_collide(velocity * delta)
	
	# Reset ground state each frame; we'll re-verify it if we hit a floor
	is_grounded = false

	if collision:
		var normal = collision.get_normal()
		
		# If the normal points upward, we hit a floor
		if normal.y < -0.7:
			is_grounded = true
		
		# Bounce velocity off whatever we hit (walls, floors, or ceilings)
		velocity = velocity.bounce(normal) * BOUNCE_DAMPENING
		
		# Prevent jitter/micro-bouncing when resting on the floor
		if is_grounded and abs(velocity.y) < 40:
			velocity.y = 0
