extends Control

var currentLine
var interruptedLines = []

var interrupted = false

var entry_point = load("res://dialog/Test1.tscn").instance()
var interrupt_point = load("res://dialog/Test3.tscn")

func _ready():
	currentLine = entry_point
	currentLine.connect("finished", self, "_on_Line_finished")
	add_child(currentLine)
	currentLine.play()

func interupt():
	interrupted = true
	
	currentLine.hide()
	currentLine.interrupt()
	interruptedLines.push_back(currentLine)

	currentLine = interrupt_point.instance()
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
	elif not nextLine and len(interruptedLines) > 0:
		currentLine.queue_free()
		currentLine = interruptedLines[-1]
		interruptedLines.pop_back()
		currentLine.show()
		currentLine.play()
