@tool
extends Node2D

@onready var itemSprite = $Sprite2D

var itemType: String
@export var itemName: String
var itemTexture: Texture2D
var itemEffect: String
var itemScenePath: String = "res://ui/inventory_sistem/inventoryItem.tscn"
var characterInRange: bool = false
var items: Dictionary = { 
	"Pao":{
		"type" = "Consumivel",
		"effect" = "++ENERGIA",
		"texture" = load("res://assets/icons_food/bread.png")
		},
	"Farinha de milho":{
		"type" = "Consumivel",
		"effect" = "+++ENERGIA",
		"texture" = load("res://assets/icons_food/corn_flour.png")
		},
	"Agua":{
		"type" = "Consumivel",
		"effect" = "++ENERGIA",
		"texture" = load("res://assets/icons_food/water.png")
		},
	"Batata":{
		"type" = "Consumivel",
		"effect" = "+ENERGIA",
		"texture" = load("res://assets/icons_food/potato.png")
		},
	"Mandioca":{
		"type" = "Consumivel",
		"effect" = "+ENERGIA",
		"texture" = load("res://assets/icons_food/mandioca.png")
		},
	"Cenoura":{
		"type" = "Consumivel",
		"effect" = "+ENERGIA",
		"texture" = load("res://assets/icons_food/carrot.png")
		}
	}
	

func _ready() -> void:
	if not Engine.is_editor_hint():
		itemSprite.texture = items[itemName]["texture"]


func _process(_delta: float) -> void:
	if  Engine.is_editor_hint():
		itemSprite.texture = itemTexture
		
	if characterInRange and Input.is_action_just_pressed("interact"):
		itemPickup()
		
		
		
func  itemPickup() -> void:
	var item = {
		"quantity" = 1,
		"name" = itemName,
		"type" = items[itemName]["type"],
		"effect" = items[itemName]["effect"],
		"texture" = items[itemName]["texture"],
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
