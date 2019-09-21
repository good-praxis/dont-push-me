extends Node

onready var button = $UI/Button
onready var dialogSystem = $UI/DialogSystem

func _ready():
	button.play_rand_animation()


func _on_PersonalSpace_mouse_entered():
	button.set_fearZone(button.FEAR_INDEX.agitated)


func _on_InnerSpace_mouse_entered():
	button.set_fearZone(button.FEAR_INDEX.anxious)
	


func _on_FreeMovementSpace_mouse_entered():
	button.set_fearZone(button.FEAR_INDEX.calm)


func _on_Button_mouse_entered():
	dialogSystem.play_dialog("What the fuck are you doing?", 0, 0, .1)
	button.set_fearZone(button.FEAR_INDEX.panicking)
