@tool
extends Node2D

@onready var itemSprite = $Sprite2D

@export var itemType: String
@export var itemName: String
@export var itemTexture: Texture2D
@export var itemEffect: String

var itemScenePath: String = "res://ui/inventory_sistem/inventoryItem.tscn"
var characterInRange: bool = false

func _ready() -> void:
	if not Engine.is_editor_hint():
		itemSprite.texture = itemTexture


func _process(_delta: float) -> void:
	if  Engine.is_editor_hint():
		itemSprite.texture = itemTexture
		
	if characterInRange and Input.is_action_just_pressed("interact"):
		itemPickup()
		
		
		
func  itemPickup() -> void:
	var item = {
		"quantity" = 1,
		"type" = itemType,
		"name" = itemName,
		"effect" = itemEffect,
		"texture" = itemTexture,
		"scenePath" = itemScenePath,
	}
	if GlobalInventory.characterNode:
		GlobalInventory.add_item(item)
		self.queue_free()


func _on_area_2d_body_entered(body:Node2D) -> void:
	if body.is_in_group("character"):
		characterInRange = true
		body.pickupLayer.visible = true

func _on_area_2d_body_exited(body:Node2D) -> void:
	if body.is_in_group("character"):
		characterInRange = false
		body.pickupLayer.visible = false
		
func set_item_data(data):
	itemName = data["name"]
	itemType = data["type"]
	itemEffect = data["effect"]
	itemTexture = data["texture"]
