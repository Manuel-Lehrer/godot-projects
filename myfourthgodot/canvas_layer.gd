extends CanvasLayer

@onready var death_screen = $/root/main/CanvasLayer/Control/DeathScreen

func show_death_screen():
	print("DEATH")
	death_screen.visible = true
	
