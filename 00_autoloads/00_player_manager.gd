extends Node

var hp: int
var player_name: String

var inventory: Array[Item]

func _ready() -> void:
	var chocolate: Item = preload("res://resources/chocolate.tres")
	
	inventory.append(chocolate)
