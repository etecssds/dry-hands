
extends Control

var vida = 5
var fome = 5
var morto = false
var pode_receber_dano = true
var pode_receber_cura = true
var pode_comer = true

@export var h_sprite1: Texture2D
@export var h_sprite2: Texture2D
@export var h_sprite3: Texture2D
@export var h_sprite4: Texture2D
@export var h_sprite5: Texture2D
@export var h_sprite6: Texture2D

@export var hungry1: Texture2D
@export var hungry2: Texture2D
@export var hungry3: Texture2D
@export var hungry4: Texture2D
@export var hungry5: Texture2D
@export var hungry6: Texture2D

var icones_vida = []
var icones_fome = []




func _ready():
	$FomeTimer.paused = true
	$Container.visible = false
	GlobalInventory.dialogOpened.connect(func()->void: $FomeTimer.paused = true)
	GlobalInventory.dialogCLosed.connect(func()->void: $FomeTimer.paused = false)
	GlobalInventory.set_VidaFome_reference(self)
	for i in range(5):
		var coracao = TextureRect.new()
		coracao.texture = h_sprite1
		coracao.custom_minimum_size = Vector2(16,16)
		coracao.size = Vector2(16,16)
		coracao.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		coracao.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		$VBoxContainer/VidaContainer.add_child(coracao)
		icones_vida.append(coracao)

	for i in range(5):
		var comida = TextureRect.new()
		comida.texture = hungry1
		comida.custom_minimum_size = Vector2(16,16)
		comida.size = Vector2(16,16)
		comida.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		comida.stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
		$VBoxContainer/FomeContainer.add_child(comida)
		icones_fome.append(comida)
	
	atualizar_interface()
	atualizar_fome()
	
func atualizar_interface():
	var textura_atual: Texture2D

	if vida == 5:
		textura_atual = h_sprite1
	elif vida == 4:
		textura_atual = h_sprite2
	elif vida == 3:
		textura_atual = h_sprite3
	elif vida == 2:
		textura_atual = h_sprite4
	elif vida == 1:
		textura_atual = h_sprite5

	for i in range(5):
		icones_vida[i].visible = true

		if i < vida:
			icones_vida[i].texture = textura_atual
		else:
			icones_vida[i].texture = h_sprite6
	
	
func animar_dano(indice: int, textura_anterior: Texture2D):
	var coracao = icones_vida[indice]
	var tween = create_tween()

	for i in range(3):
		tween.tween_callback(func(): coracao.texture = h_sprite6)
		tween.tween_interval(0.12)
		tween.tween_callback(func(): coracao.texture = textura_anterior)
		tween.tween_interval(0.12)

	await tween.finished

	coracao.texture = h_sprite6

func animar_cura(indice: int):
	var coracao = icones_vida[indice]
	var textura_final = coracao.texture
	coracao.texture = h_sprite6
	var tween = create_tween()

	for i in range(3):
		tween.tween_callback(func(): coracao.texture = textura_final)
		tween.tween_interval(0.12)
		tween.tween_callback(func(): coracao.texture = h_sprite6)
		tween.tween_interval(0.12)

	await tween.finished

	coracao.texture = textura_final
	
func receber_dano():
	if not pode_receber_dano or morto or vida <= 0:
		return
	
	pode_receber_dano = false

	var indice_perdido = vida - 1
	var textura_anterior = icones_vida[indice_perdido].texture

	vida -= 1

	print("Dano recebido! Vida:", vida)

	atualizar_interface()

	if vida == 0:
		morto = true
		print("Player morreu")
		$Container.visible = true

	animar_dano(indice_perdido, textura_anterior)

	if not is_inside_tree():
		return
	await get_tree().create_timer(1.0).timeout

	pode_receber_dano = true
	

func receber_cura(vidaAdicional: int, fomeAdicional:int):
	if not pode_receber_cura or not pode_comer or morto:
		return

	if fome >= 5 and vida >= 5:
		return

	pode_receber_cura = false
	pode_comer = false

	var vida_anterior = vida
	var fome_anterior = fome
	
	fome = min(fome + fomeAdicional, 5)
	vida = min(vida + vidaAdicional, 5)

	print("Fome:", fome)
	print("Vida:", vida)

	if vida > vida_anterior:
		atualizar_interface()
		animar_cura(vida_anterior)

	if fome > fome_anterior:
		atualizar_fome()

		var textura_nova = icones_fome[fome_anterior].texture
		piscar_icone(icones_fome[fome_anterior], true, hungry6, textura_nova)
		
	await get_tree().create_timer(1.0).timeout

	pode_receber_cura = true
	pode_comer = true
	
func atualizar_fome():
	var textura_atual: Texture2D = hungry6

	if fome == 5:
		textura_atual = hungry1
	elif fome == 4:
		textura_atual = hungry2
	elif fome == 3:
		textura_atual = hungry3
	elif fome == 2:
		textura_atual = hungry4
	elif fome == 1:
		textura_atual = hungry5

	for i in range(5):
		icones_fome[i].visible = true

		if i < fome:
			icones_fome[i].texture = textura_atual
		else:
			icones_fome[i].texture = hungry6
			

func piscar_icone(icone: TextureRect, estado_final: bool, textura_anterior: Texture2D = null, textura_vazia: Texture2D = null):
	var tween = create_tween()

	for i in range(3):
		if textura_vazia != null:
			tween.tween_callback(func(): icone.texture = textura_vazia)
		else:
			tween.tween_callback(func(): icone.visible = false)

		tween.tween_interval(0.12)

		if textura_anterior != null:
			tween.tween_callback(func(): icone.texture = textura_anterior)
		else:
			tween.tween_callback(func(): icone.visible = true)

		tween.tween_interval(0.12)

	await tween.finished

	if textura_vazia != null:
		icone.texture = textura_vazia
	else:
		icone.visible = estado_final
		


func _on_fome_timer_timeout() -> void:
	if morto:
		return

	if fome > 0:
		var indice_perdido = fome - 1
		var textura_anterior = icones_fome[indice_perdido].texture

		fome -= 1

		print("Fome:", fome)

		atualizar_fome()
		piscar_icone(icones_fome[indice_perdido], true, textura_anterior, hungry6)
	else:
		receber_dano()

	print("Vida:", vida)
	


func _on_death_timer_timeout() -> void:
	if morto:
		GlobalInventory.playerDied.emit()
	else:
			return
		
