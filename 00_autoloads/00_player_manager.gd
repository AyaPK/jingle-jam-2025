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
	var mirror: Item = preload("res://resources/items/mirror.tres")
	var watch: Item = preload("res://resources/items/watch.tres")
	var documents: Item = preload("res://resources/items/documents.tres")
	var plushie: Item = preload("res://resources/items/plushie.tres")
	inventory.append(chocolate)
	inventory.append(documents)
	inventory.append(watch)
	inventory.append(mirror)
	inventory.append(plushie)
	inventory.append(flowers)
	inventory.append(dagger)
	
	for i in range(1, 7):
		var insult_dialog = load("res://resources/dialog/player/insult_" + str(i) + ".tres")
		insult_dialog_pool.append(insult_dialog)
		
	for i in range(1, 7):
		var seduction_dialog = load("res://resources/dialog/player/seduction_" + str(i) + ".tres")
		seduction_dialog_pool.append(seduction_dialog)

func refresh() -> void:
	inventory = []
	insult_dialog_pool = []
	seduction_dialog_pool = []
	var chocolate: Item = preload("res://resources/items/chocolate.tres")
	var flowers: Item = preload("res://resources/items/flowers.tres")
	var dagger: Item = preload("res://resources/items/dagger.tres")
	var mirror: Item = preload("res://resources/items/mirror.tres")
	var watch: Item = preload("res://resources/items/watch.tres")
	var documents: Item = preload("res://resources/items/documents.tres")
	var plushie: Item = preload("res://resources/items/plushie.tres")
	inventory.append(chocolate)
	inventory.append(documents)
	inventory.append(watch)
	inventory.append(mirror)
	inventory.append(plushie)
	inventory.append(flowers)
	inventory.append(dagger)
	
	for i in range(1, 7):
		var insult_dialog = load("res://resources/dialog/player/insult_" + str(i) + ".tres")
		insult_dialog_pool.append(insult_dialog)
		
	for i in range(1, 7):
		var seduction_dialog = load("res://resources/dialog/player/seduction_" + str(i) + ".tres")
		seduction_dialog_pool.append(seduction_dialog)

func reset_player_health() -> void:
	hp = MAX_HP

func loot_demon(demon: Demon) -> void:
	var demon_common_dialog = demon.battle_dialog.filter(func(dialog: Dialog): return dialog.rarity == Dialog.DIALOG_RARITY.COMMON)
	var demon_rare_dialog = demon.battle_dialog.filter(func(dialog: Dialog): return dialog.rarity == Dialog.DIALOG_RARITY.RARE)
	var demon_ultra_rare_dialog = demon.battle_dialog.filter(func(dialog: Dialog): return dialog.rarity == Dialog.DIALOG_RARITY.ULTRA_RARE)
	
	if (demon_common_dialog.size() > 0): _add_dialog_to_pool(demon_common_dialog.pick_random())
	if (demon_rare_dialog.size() > 0): _add_dialog_to_pool(demon_rare_dialog.pick_random())
	if (demon_ultra_rare_dialog.size() > 0): _add_dialog_to_pool(demon_ultra_rare_dialog.pick_random())

func _add_dialog_to_pool(dialog: Dialog) -> void:
	if dialog.type == Dialog.DIALOG_TYPE.ATTACK:
		insult_dialog_pool.append(dialog)
	else:
		seduction_dialog_pool.append(dialog)
