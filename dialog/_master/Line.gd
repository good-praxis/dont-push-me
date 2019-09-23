extends Label

export(String, FILE) var nextLine
export(String, MULTILINE) var lineText
export(bool) var is_interupt = false

signal finished

var interupted = false

func play():
	interupted = false
	self.text = ""
	for letter in lineText:
		if interupted:
			break
		if letter in " .,!?'\"" or !self.text:
			self.text += letter
			continue
		
		yield(get_tree().create_timer(0.05), "timeout")
		self.text += letter
	
	if not interupted:
		emit_signal("finished", nextLine)
	
func interupt():
	interupted = true
	
func get_lineText():
	return lineText
	
func same_as(other_line):
	return self.lineText == other_line.get_lineText()