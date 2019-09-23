extends Control

var currentLine
var interuptedLines = []

var interupted = false

func start(line_path):
	currentLine = load(line_path).instance()
	currentLine.connect("finished", self, "_on_Line_finished")
	add_child(currentLine)
	currentLine.play()

func interupt(interuption_path, clear_all = false, clear_interupts = true):
	var interuptionLine = load(interuption_path).instance()
	if not currentLine:
		currentLine = interuptionLine
		currentLine.connect("finished", self, "_on_Line_finished")
		add_child(currentLine)
		currentLine.play()
		return
		
	if currentLine.same_as(interuptionLine):
		return
		
	interupted = true
	
	currentLine.hide()
	currentLine.interupt()
	
	if (clear_interupts and not currentLine.is_interupt) or not clear_interupts:
		interuptedLines.push_back(currentLine)
		
	if clear_all:
		for line in interuptedLines:
			line.queue_free()
		interuptedLines = []

	currentLine = interuptionLine
	currentLine.connect("finished", self, "_on_Line_finished")
	add_child(currentLine)
	currentLine.play()



func play_dialog(_one, _two):
	pass
	
func _on_Line_finished(nextLine = null):
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
	else:
		currentLine.queue_free()
		currentLine = null
