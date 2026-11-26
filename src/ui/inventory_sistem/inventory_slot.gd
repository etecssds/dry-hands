extends Control

@onready var icon: Sprite2D = $itemButton/itemIcon
@onready var qtd: Label = $itemButton/itemQuantity
@onready var detailPanel: ColorRect = $detailPanel
@onready var detailName: Label = $detailPanel/itemName
@onready var detailType: Label = $detailPanel/itemType
@onready var detailEffect: Label = $detailPanel/itemEffect
@onready var usagePanel: ColorRect = $usagePanel
@onready var buttonTexture: TextureButton = $itemButton
@onready var audioPlayer: AudioStreamPlayer = $AudioStreamPlayer

var item = null

func _on_item_button_pressed() -> void:
	if item != null:
		buttonTexture.texture_normal = buttonTexture.texture_hover
		usagePanel.visible = !usagePanel.visible
		detailPanel.visible = false

func _on_item_button_mouse_entered() -> void:
	if item != null:
		buttonTexture.texture_normal = load("res://assets/ui/frames/hot bar selecionada.png")
		usagePanel.visible = false
		detailPanel.visible = true


func _on_item_button_mouse_exited() -> void:
	detailPanel.visible = false
	
func setEmpty() -> void:
	icon.texture = null
	qtd.text = ""
	
func setItem(newItem):
	item = newItem
	icon.texture = item["texture"]
	qtd.text = str(item["quantity"])
	detailName.text = str(item["name"])
	detailType.text = str(item["type"])
	detailEffect.text = str(item["effect"])
	


func _on_drop_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	if item != null:
		var dropPosition = GlobalInventory.characterNode.global_position
		var dropOffset = Vector2(0,20)
		GlobalInventory.drop_item(item, dropPosition + dropOffset)
		GlobalInventory.remove_item(item)
		usagePanel.visible = false

func _on_use_pressed() -> void:
	sonudSelector()
	await audioPlayer.finished
	if item != null and item["effect"] != "":
		if item["effect"] == "+ENERGIA":
			GlobalInventory.vidaFomeNode.receber_cura(1,1)
		if item["effect"] == "++ENERGIA":
			GlobalInventory.vidaFomeNode.receber_cura(1,2)
		if item["effect"] == "+++ENERGIA":
			GlobalInventory.vidaFomeNode.receber_cura(2,3)
		GlobalInventory.remove_item(item)

func sonudSelector():
	var sound: int = randi_range(1,3)
	if sound == 1:
		audioPlayer.stream = load("res://assets/sounds/click1.wav")
	elif sound == 2: 
		audioPlayer.stream = load("res://assets/sounds/click2.mp3")
	elif sound == 3:
		audioPlayer.stream = load("res://assets/sounds/click3.ogg")
	audioPlayer.play()
