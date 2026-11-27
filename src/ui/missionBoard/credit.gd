class_name  Credits
extends Node2D


func _process(_delta: float) -> void:
	if GlobalInventory.Finisher:
		$credt_Layer.visible = true
	
