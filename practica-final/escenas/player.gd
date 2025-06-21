class_name player extends CharacterBody2D
@onready var sprites = $AnimatedSprite2D;
@export var fletxa: PackedScene

const SPEED = 300.0
const JUMP_VELOCITY = -350.0
#const GRAVITY = 981

var viu: bool = true
var fent_animacio:bool = false #Per a evitar fer el idle cuan no toca
var pare = null #per a saber la escena on som
var potAtacar1: bool = true
var potAtacar2: bool = true
var tipusAtac: int = 1 # 1 és un atac a distància, 2 és a melee
var velAtac1 = 300

func _ready() -> void:
	viu = true
	pare = get_parent()


func _physics_process(delta: float) -> void: #Aixo es fa a cada frame
	# Add the gravity.
	if not viu:
		return
	if not is_on_floor():
		velocity += get_gravity() * delta
		if velocity.y < 0 and not fent_animacio:
			sprites.play("jump")
			#sprites.play("jump")
		elif velocity.y > 0 and not fent_animacio:
			sprites.play("fall")
	# Handle jump.
	elif Input.is_action_just_pressed("ui_salt"):
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("ui_esq", "ui_dret")
	if direction:
		velocity.x = direction * SPEED
		sprites.flip_h = direction < 0
		if not fent_animacio:
			sprites.play("run");
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if viu and not fent_animacio:
			sprites.play("idle")
	
	if Input.is_action_just_pressed("ui_atac"):
		atacar()
	
	move_and_slide()

func morir(): #es fa cuan mor
	if not viu: #Per a evitar morir mes d'un cop i perdre mes vides de les que toca
		return
	viu = false
	sprites.play("mor")
	await sprites.animation_finished
	VaraiablesGlobals.restarVida() 
	if VaraiablesGlobals.vides > 0: #Si arriba a 0 el metode restarVida ja ens porta a la pantalla final
		get_tree().reload_current_scene()
	#fer respawn?

func _on_temps_atac_1_timeout() -> void:
	potAtacar1 = true #Per a anar reiniciant els temps d'atac

func atacar() -> void:
	if not viu:
		return
	if tipusAtac == 1 and potAtacar1: # ATAC A DISTÀNCIA
		fent_animacio = true
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
		await sprites.animation_finished
		fent_animacio = false
	elif tipusAtac == 2 and potAtacar2: # ATAC A MELEE
		fent_animacio = true
		sprites.play("melee")
		$atacMelee.monitoring = true
		$duracioAtac2.start()
		await sprites.animation_finished
		fent_animacio = false

func canviarAtac(): # canvia a l'atac que correspon
	if tipusAtac == 1:
		tipusAtac = 2
	else:
		tipusAtac = 1
	$SoCanvi.play()

#Reinicia el atac 2
func _on_temps_atac_2_timeout() -> void:
	potAtacar2 = true

#Activem la hitbox del atac_2
func _on_duracio_atac_2_timeout() -> void:
	$atacMelee.monitoring = false
	potAtacar2 = false
	$tempsAtac2.start()

#Detectem si algo esta dins de la hitbox d'atac_2 i ho tractem
func _on_atac_melee_body_entered(body: Node2D) -> void:
	if body is not player:
		if body is enemic and body.has_method("morir"):
			body.morir()

#Aqui anem fent els canvis d'atac
func _on_canvi_atac_timeout() -> void:
	canviarAtac()

#Aqui fem el tema de destruccio de projectil ja que no podem fer-ho amb el body
func _on_atac_melee_area_entered(area: Area2D) -> void:
	var pare_a = area.get_parent() #Ho hem de fer aixi perque sino no es poden detectar els projectils
	if pare_a is projectil:
		pare_a.destruir()
