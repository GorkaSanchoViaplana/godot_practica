class_name player extends CharacterBody2D
@onready var sprites = $AnimatedSprite2D;
@export var fletxa: PackedScene

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
#const GRAVITY = 981

var viu: bool = true
var potAtacar1: bool = true
var tipusAtac: int = 1 # 1 és un atac a distància
var velAtac1 = 300

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
	
	if Input.is_action_just_pressed("ui_atac") and potAtacar1:
		atacar()
	
	move_and_slide()

func morir():
	viu = false
	sprites.play("mor")
	await sprites.animation_finished
	VaraiablesGlobals.vides -= 1
	get_tree().reload_current_scene()
	#fer respawn?

func _on_temps_atac_1_timeout() -> void:
	potAtacar1 = true

func atacar() -> void:
	sprites.play("atac")
	print("ATACANT")
	if tipusAtac == 1: # ATAC A DISTÀNCIA
		var posRatoli = get_global_mouse_position()
		var atac = fletxa.instantiate()
		var direccio = (posRatoli - global_position).normalized()
		atac.global_position = global_position
		atac.linear_velocity = direccio * velAtac1 
		
		get_tree().current_scene.add_child(atac)
	potAtacar1 = false
	$tempsAtac1.start()

func canviarAtac(atac: int): # canvia a l'atac que correspon
	pass
