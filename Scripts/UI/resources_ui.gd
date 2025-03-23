extends Control



func _ready():
	CommunicationBus.listen_to_signal("update_resources", _on_update_resources)

func _on_update_resources(resources: Dictionary):
	var acorn_cur_value = int($"Acorn/Acorn Value".text)
	var population_cur_value = int($"Population/Population Value".text)
	var loyalty_cur_value = int($"Loyalty/Loyalty Value".text)

	if acorn_cur_value != resources[EnumsClassesConsts.KingdomResourceTypes.Acorn]:
		print("updating resources")
		$"Acorn/Acorn Value".text = str(resources[EnumsClassesConsts.KingdomResourceTypes.Acorn])
	if population_cur_value != resources[EnumsClassesConsts.KingdomResourceTypes.Population]:
		$"Population/Population Value".text = str(resources[EnumsClassesConsts.KingdomResourceTypes.Population])
	if loyalty_cur_value != resources[EnumsClassesConsts.KingdomResourceTypes.Loyalty]:
		$"Loyalty/Loyalty Value".text = str(resources[EnumsClassesConsts.KingdomResourceTypes.Loyalty])
