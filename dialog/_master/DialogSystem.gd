extends Control

var currentLine
var interuptedLines = []

var interupted = false

var entry_point = load("res://dialog/Test1.tscn").instance()
var interupt_point = load("res://dialog/Test3.tscn")

func _ready():
	currentLine = entry_point
	currentLine.connect("finished", self, "_on_Line_finished")
	add_child(currentLine)
	currentLine.play()

func interupt(clear_all = false, clear_interupts = true):
	interupted = true
	
	currentLine.hide()
	currentLine.interupt()
	
	if (clear_interupts and not currentLine.is_interupt) or not clear_interupts:
		interuptedLines.push_back(currentLine)
		
	if clear_all:
		interuptedLines = []

	currentLine = interupt_point.instance()
	currentLine.connect("finished", self, "_on_Line_finished")
	add_child(currentLine)
	currentLine.play()



func play_dialog(_one, _two):
	pass
	
func _on_Line_finished(nextLine = null, text = ""):
	yield(get_tree().create_timer(1.5), "timeout")
		
	if currentLine.nextLine and nextLine == currentLine.nextLine:
		currentLine.queue_free()
		currentLine = load(nextLine).instance()
		currentLine.connect("finished", self, "_on_Line_finished")
		add_child(currentLine)
		currentLine.play()
	elif not nextLine and len(interuptedLines) > 0:
		currentLine.queue_free()
		currentLine = interuptedLines[-1]
		interuptedLines.pop_back()
		currentLine.show()
		currentLine.play()
