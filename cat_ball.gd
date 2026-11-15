extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
var velocity = 0

func bounce():
	velocity = velocity * 0.9
	self.rotate(180)
	

func _physics_process(delta: float) -> void:
	if is_zero_approx(velocity):
		velocity = 0
