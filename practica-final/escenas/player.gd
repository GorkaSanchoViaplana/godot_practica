class_name player extends CharacterBody2D
@onready var sprites = $AnimatedSprite2D;
@export var fletxa: PackedScene

const SPEED = 300.0
const JUMP_VELOCITY = -350.0
#const GRAVITY = 981

var viu: bool = true
var pare = null
var potAtacar1: bool = true
var potAtacar2: bool = true
var tipusAtac: int = 1 # 1 és un atac a distància, 2 és a melee
var velAtac1 = 300

func _ready() -> void:
	viu = true
	pare = get_parent()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not viu:
		return
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
	
	if Input.is_action_just_pressed("ui_atac"):
		atacar()
	
	move_and_slide()

func morir():
	if not viu:
		return
	viu = false
	sprites.play("mor")
	await sprites.animation_finished
	VaraiablesGlobals.restarVida() 
	if VaraiablesGlobals.vides > 0:
		get_tree().reload_current_scene()
	#fer respawn?

func _on_temps_atac_1_timeout() -> void:
	potAtacar1 = true

func atacar() -> void:
	if not viu:
		return
	if tipusAtac == 1 and potAtacar1: # ATAC A DISTÀNCIA
		sprites.play("atac")
		var posRatoli = get_global_mouse_position()
		var atac = fletxa.instantiate()
		var direccio = (posRatoli - global_position).normalized()
		atac.global_position = global_position
		atac.linear_velocity = direccio * velAtac1 
		atac.rotation = direccio.angle()
		potAtacar1 = false
		$tempsAtac1.start()
		
		get_tree().current_scene.add_child(atac)
		
	elif tipusAtac == 2 and potAtacar2: # ATAC A MELEE
		sprites.play("melee")
		$atacMelee.monitoring = true
		$duracioAtac2.start()
		
	

func canviarAtac(): # canvia a l'atac que correspon
	if tipusAtac == 1:
		tipusAtac = 2
	else:
		tipusAtac = 1
	$SoCanvi.play()

func _on_temps_atac_2_timeout() -> void:
	potAtacar2 = true

func _on_duracio_atac_2_timeout() -> void:
	$atacMelee.monitoring = false
	potAtacar2 = false
	$tempsAtac2.start()

func _on_atac_melee_body_entered(body: Node2D) -> void:
	if body is not player:
		if body is enemic and body.has_method("morir"):
			body.morir()

func _on_canvi_atac_timeout() -> void:
	canviarAtac()
