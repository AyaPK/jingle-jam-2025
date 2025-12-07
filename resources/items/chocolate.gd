class_name ChocolateItemEffect extends ItemEffect

func trigger() -> void:
	var demon = BattleManager.current_demon

	DialogPanel.push_text("You gave the chocolate to %s!" % demon.demon_name)

	if BattleManager.current_demon.internal_name in ["Gluttony"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Oh! I love chocolate!", demon)
	elif BattleManager.current_demon.internal_name in ["Lust", "Sloth", "Greed"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text("Thanks.", demon)
	elif BattleManager.current_demon.internal_name in ["Wrath", "Envy"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text("I'm not a fan of chocolate.", demon)
	elif BattleManager.current_demon.internal_name in ["Pride"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text("oh! Ew ew ew! No way! Too fattening!", demon)
	
