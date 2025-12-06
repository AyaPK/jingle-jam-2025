extends Node

const MAX_HP = 100

var hp: int = MAX_HP
var player_name: String

var inventory: Array[Item]
var insult_dialog_pool: Array[Dialog]
var seduction_dialog_pool: Array[Dialog]

func _ready() -> void:
	Signals.battle_left.connect(reset_player_health)
	
	var chocolate: Item = preload("res://resources/items/chocolate.tres")
	var flowers: Item = preload("res://resources/items/flowers.tres")
	var dagger: Item = preload("res://resources/items/dagger.tres")
	inventory.append(chocolate)
	inventory.append(flowers)
	inventory.append(dagger)
	
	for i in range(1, 7):
		var insult_dialog = load("res://resources/dialog/insult_" + str(i) + ".tres")
		insult_dialog_pool.append(insult_dialog)
		
	for i in range(1, 7):
		var seduction_dialog = load("res://resources/dialog/seduction_" + str(i) + ".tres")
		seduction_dialog_pool.append(seduction_dialog)

func reset_player_health() -> void:
	hp = MAX_HP
