extends BTDecorator
class_name HasContactAlert

var result = false

func _pre_tick(agent: Node, blackboard: Blackboard) -> void:
	
	if blackboard.get_data("CONTACT ALERT"):
		result = true


func _tick(agent: Node, blackboard: Blackboard) -> bool:
	
	if result:
		return super._tick(agent, blackboard)
	return fail()

