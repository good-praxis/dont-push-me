extends Node


onready var button = $UI/Button
onready var dialogSystem = $UI/DialogSystem

var Dialogs = {
	Debug = {
		Test1 = "res://dialog/Test1.tscn", 
		Test2 = "res://dialog/Test2.tscn", 
		Test3 = "res://dialog/Test3.tscn"
		},
	ActI = {
		Greeting01 = "res://dialog/actI/Greeting01.tscn",
		Greeting02 = "res://dialog/actI/Greeting02.tscn",
		Greeting03 = "res://dialog/actI/Greeting03.tscn",
		TooClose01 = "res://dialog/actI/TooClose01.tscn",
		TooClose02 = "res://dialog/actI/TooClose02.tscn"
		},
	}
	

func _ready():
	button.play_rand_animation()
	dialogSystem.start(Dialogs.ActI.Greeting01)


func _on_PersonalSpace_mouse_entered():
	button.set_fearZone(button.FEAR_INDEX.agitated)


func _on_InnerSpace_mouse_entered():
	button.set_fearZone(button.FEAR_INDEX.anxious)
	


func _on_FreeMovementSpace_mouse_entered():
	dialogSystem.play_dialog("Finally some motherfricking breathing space", .1)
	button.set_fearZone(button.FEAR_INDEX.calm)


func _on_Button_mouse_entered():
	dialogSystem.play_dialog("What the frick are you doing?", .05)
	button.set_fearZone(button.FEAR_INDEX.panicking)


func _on_Button_isAnxious():
	dialogSystem.interupt(Dialogs.ActI.TooClose01, true)
