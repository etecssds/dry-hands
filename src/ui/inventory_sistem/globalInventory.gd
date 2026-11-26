extends Node

@onready var inventorySlotScene = preload("res://ui/inventory_sistem/inventorySlot.tscn")

var vidaFomeNode: Node = null
var inventory: Array = []
var characterNode: Node = null

signal inventoryUpdate
signal dialogOpened
signal dialogCLosed
signal playerDied

func _ready() -> void:
	restart_inventory()

func add_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["name"] == item["name"]:
			inventory[i]["quantity"] += item["quantity"]
			inventoryUpdate.emit()
			print("adiciono", inventory)
			return true
		elif inventory[i] == null:
			inventory[i] = item
			inventoryUpdate.emit()
			print("adiciono", inventory)
			return true
	print("nao foi", inventory)
	return false

func remove_item(item):
	for i in range(inventory.size()):
		if inventory[i] != null and inventory[i]["type"] == item["type"] and inventory[i]["name"] == item["name"]:
			inventory[i]["quantity"] -= 1
			if inventory[i]["quantity"] <=0:
				inventory[i] = null
			inventoryUpdate.emit()
			return true
	return false
	
	
func set_character_reference(character) ->void:
	characterNode = character
func set_VidaFome_reference(vidaFome) ->void:
	vidaFomeNode = vidaFome
	
func ajust_drop_position(position):
	var dropArea =20
	var nearbyItens = get_tree().get_nodes_in_group("items")
	for item in nearbyItens:
		if item.global_position.distance_to(position) < dropArea:
			var randomOffset = Vector2(randf_range(-dropArea,dropArea),randf_range(-dropArea,dropArea))
			position += randomOffset
			break
	return position
	
func drop_item(itemData, dropPosition):
	var itemScene = load(itemData["scenePath"])
	var itemInstance = itemScene.instantiate()
	itemInstance.set_item_data(itemData)
	dropPosition = ajust_drop_position(dropPosition)
	itemInstance.global_position = dropPosition
	get_tree().current_scene.get_node("items").add_child(itemInstance)
	
func restart_inventory():
	inventory = []
	inventory.resize(4)
	
