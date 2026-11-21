extends Control

@onready var icon: Sprite2D = $NinePatchRect/itemIcon
@onready var qtd: Label = $NinePatchRect/itemQuantity
@onready var detailPanel: ColorRect = $detailPanel
@onready var detailName: Label = $detailPanel/itemName
@onready var detailType: Label = $detailPanel/itemType
@onready var detailEffect: Label = $detailPanel/itemEffect
@onready var usagePanel: ColorRect = $usagePanel

var item = null

func _on_item_button_pressed() -> void:
	if item != null:
		usagePanel.visible = !usagePanel.visible
		detailPanel.visible = false

func _on_item_button_mouse_entered() -> void:
	if item != null:
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
	if item != null:
		var dropPosition = GlobalInventory.characterNode.global_position
		var dropOffset = Vector2(0,20)
		GlobalInventory.drop_item(item, dropPosition + dropOffset)
		GlobalInventory.remove_item(item)
		usagePanel.visible = false

func _on_use_pressed() -> void:
	if item != null and item["effect"] != "":
		if item["effect"] == "sapato":
			get_tree().current_scene
		GlobalInventory.remove_item(item)
