extends Node

var days : int = 1
var months : int = 1
var years : int = 1
var days_raw : int = 1

#func _process(delta):
func _ready():
	while not GVariables.GAME_READY :
			await get_tree().create_timer(0.05).timeout
	while true :
		await get_tree().create_timer(1).timeout
		days += 1
		days_raw += 1
		if days == 31:# +1 months, set days to 1
			days = 1
			months += 1
		if months == 13:# +1 year, set months to 1
			months = 1
			years += 1
	
	
	
