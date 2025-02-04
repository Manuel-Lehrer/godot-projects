extends Control

var coin_count = 0
@onready var rich_label = $"/root/main/Control/Panel/RichTextLabel"

func add_coin():
	coin_count += 1
	rich_label.text = "[center]Coins: [color=yellow]" + str(coin_count) + "[/color][/center]"
