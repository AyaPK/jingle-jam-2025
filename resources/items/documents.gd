class_name DocumentsItemEffect extends ItemEffect

func trigger() -> void:
	var demon = BattleManager.current_demon

	DialogPanel.push_text("You suggested %s take the confidential documents" % demon.demon_name)

	if BattleManager.current_demon.internal_name in ["Lust"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Oh you wouldn't. How naughty.", demon)
	elif BattleManager.current_demon.internal_name in ["Greed", "Envy", "Wrath"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("Very sneaky. Nice!", demon)
	elif BattleManager.current_demon.internal_name in ["Gluttony", "Sloth"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("Uhhh. Ok?", demon)
	elif BattleManager.current_demon.internal_name in ["Pride"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("WHAT AM I MEANT TO DO WITH THESE?!?", demon)
	
