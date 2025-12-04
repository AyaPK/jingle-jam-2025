class_name ChocolateEffect extends ItemEffect

func trigger() -> void:
	DialogPanel.push_text("You used the chocolate!")
	if BattleManager.current_demon.demon_name in ["Gluttony"]:
		BattleManager.demon_seduction += 50
		DialogPanel.push_text("Gluttony: Oh! I love chocolate!")
	elif BattleManager.current_demon.demon_name in ["Lust", "Sloth", "Greed"]:
		BattleManager.demon_seduction += 10
		DialogPanel.push_text(BattleManager.current_demon.demon_name+": Thanks.")
	elif BattleManager.current_demon.demon_name in ["Wrath", "Envy"]:
		BattleManager.demon_seduction -= 10
		DialogPanel.push_text(BattleManager.current_demon.demon_name+": I'm not a fan of chocolate.")
	elif BattleManager.current_demon.demon_name in ["Pride"]:
		BattleManager.demon_seduction -= 50
		DialogPanel.push_text(BattleManager.current_demon.demon_name+": oh! Ew ew ew! No way! Too fattening!")
	
