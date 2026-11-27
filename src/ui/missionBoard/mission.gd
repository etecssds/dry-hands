extends Control

var danificacoesEncontradas: int = 0
var chaoArados:int =0
var playerInRange = false
var in_mission_1_1 = false
var in_mission_1_2 = false
var in_mission_1_3 = false
var in_mission_2_1 = false
var in_mission_2_2 = false
var in_mission_2_3 = false
var level_2 = Level2
var credit = Credits

@onready var mission1Text: RichTextLabel =$NinePatchRect/ScrollContainer/level2/mission1
@onready var mission2Text: RichTextLabel =$NinePatchRect/ScrollContainer/level2/mission2



func  _process(_delta: float) -> void:
	if GlobalInventory.change_scene:
		$NinePatchRect/ScrollContainer/level1.visible = false
		$NinePatchRect/ScrollContainer/level2.visible = true
		
		
	if danificacoesEncontradas >=3:
		mission1Text.visible = false
	
	if chaoArados >=3:
		mission2Text.visible = false
		
	if not mission1Text.visible and not mission2Text.visible:
		$NinePatchRect/ScrollContainer/level2/complete.visible = true

func _input(event: InputEvent) -> void:
	if  event.is_action_pressed("interact") and in_mission_1_1:
		danificacoesEncontradas +=1
		$"../../Mission_1_1".queue_free()
	if event.is_action_pressed("interact") and in_mission_1_2:
		danificacoesEncontradas +=1
		$"../../Mission_1_2".queue_free()
	if event.is_action_pressed("interact") and in_mission_1_3:
		danificacoesEncontradas +=1
		$"../../Mission_1_3".queue_free()
	if event.is_action_pressed("interact") and in_mission_2_1:
		chaoArados +=1
		$"../../terras_aradas_1".visible = true
		$"../../Mission_2_1".queue_free()
	if event.is_action_pressed("interact") and in_mission_2_2:
		chaoArados +=1
		$"../../terras_aradas_2".visible = true
		$"../../Mission_2_2".queue_free()
	if event.is_action_pressed("interact") and in_mission_2_3:
		chaoArados +=1
		$"../../terras_aradas_3".visible = true
		$"../../Mission_2_3".queue_free()
		


func player_enter(player: Node2D):
	if player.is_in_group("character"):
		player.pickupLayer.visible = true
		return true
	return false
	
	
func player_exit(player: Node2D):
	if player.is_in_group("character"):
		player.pickupLayer.visible = false
		return true
	return false


func _on_mission_1_1_body_entered(body: Node2D) -> void:
	if player_enter(body):
		in_mission_1_1 = true

func _on_mission_1_2_body_entered(body: Node2D) -> void:
	if player_enter(body):
		in_mission_1_2 = true

func _on_mission_1_3_body_entered(body: Node2D) -> void:
	if player_enter(body):
		in_mission_1_3 = true


func _on_mission_1_1_body_exited(body: Node2D) -> void:
	if player_exit(body):
		in_mission_1_1 = false


func _on_mission_1_2_body_exited(body: Node2D) -> void:
	if player_exit(body):
		in_mission_1_2 = false


func _on_mission_1_3_body_exited(body: Node2D) -> void:
	if player_exit(body):
		in_mission_1_3 = false


func _on_mission_2_1_body_entered(body: Node2D) -> void:
	if player_enter(body):
		in_mission_2_1 = true

func _on_mission_2_1_body_exited(body: Node2D) -> void:
	if player_exit(body):
		in_mission_2_1 = false

func _on_mission_2_2_body_entered(body: Node2D) -> void:
	if player_enter(body):
		in_mission_2_2 = true

func _on_mission_2_2_body_exited(body: Node2D) -> void:
	if player_exit(body):
		in_mission_2_2 = false

func _on_mission_2_3_body_entered(body: Node2D) -> void:
	if player_enter(body):
		in_mission_2_3 = true

func _on_mission_2_3_body_exited(body: Node2D) -> void:
	if player_exit(body):
		in_mission_2_3 = false


func _on_house_body_entered(body: Node2D) -> void:
	if body.is_in_group("character"):
		if $NinePatchRect/ScrollContainer/level2/complete.visible:
			GlobalInventory.Finisher = true
			$"../../DialogLayer".visible = false
			$"../../PauseMenuLayer".visible = false
			$"..".visible = false
			$"../../MobileControlsLayer".visible = false
			
