extends Node

var hp: int
var player_name: String

var inventory: Array[Item]

func _ready() -> void:
	var chocolate: Item = preload("res://resources/chocolate.tres")
	var flowers: Item = preload("res://resources/flowers.tres")
	inventory.append(chocolate)
	inventory.append(flowers)
