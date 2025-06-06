class_name player extends CharacterBody2D
@onready var sprites = $AnimatedSprite2D;

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#const GRAVITY = 981

var viu: bool = true

func _ready() -> void:
	viu = true

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0:
			sprites.play("jump")
		elif velocity.y > 0:
			sprites.play("fall")
	# Handle jump.
	elif Input.is_action_just_pressed("ui_salt"):
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_esq", "ui_dret")
	if direction:
		velocity.x = direction * SPEED
		sprites.flip_h = direction < 0
		sprites.play("run");
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if viu:
			sprites.play("idle")
	move_and_slide()

func morir():
	print("NO PUC MES")
	viu = false
	sprites.play("mor")
	await sprites.animation_finished
	VaraiablesGlobals.vides -= 1
	get_tree().reload_current_scene()
	#fer respawn?
