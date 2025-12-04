extends Node

var hp: int
var player_name: String

var inventory: Array[Item]
var insult_dialog_pool: Array[Dialog]
var seduction_dialog_pool: Array[Dialog]

func _ready() -> void:
	var chocolate: Item = preload("res://resources/items/chocolate.tres")
	var flowers: Item = preload("res://resources/items/flowers.tres")
	inventory.append(chocolate)
	inventory.append(flowers)
	
	for i in range(1, 7):
		var insult_dialog = load("res://resources/dialog/insult_" + str(i) + ".tres")
		insult_dialog_pool.append(insult_dialog)
		
	for i in range(1, 7):
		var seduction_dialog = load("res://resources/dialog/seduction_" + str(i) + ".tres")
		seduction_dialog_pool.append(seduction_dialog)
