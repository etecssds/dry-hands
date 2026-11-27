extends Control

var animaisVistos: int = 0
var danificacoesEncontradas: int = 0
var chaoArados:int =0
var playerInRange = false

@onready var mission1Text: RichTextLabel =$NinePatchRect/ScrollContainer/level2/mission1
@onready var mission2Text: RichTextLabel =$NinePatchRect/ScrollContainer/level2/mission2
@onready var mission3Text: RichTextLabel =$NinePatchRect/ScrollContainer/level2/mission3

func _input(event: InputEvent) -> void:
	if playerInRange and event.is_action_pressed("interact"):
		


func _on_mission_1_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		body.pickupLayer.visible = true


func _on_mission_2_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		body.pickupLayer.visible = true

func _on_mission_3_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		body.pickupLayer.visible = true
