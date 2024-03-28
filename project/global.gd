extends Node

var sel_costume = 1
var sel_hair = 1

var quest = 0
var quests = ["Talk to grandma", "Go outside", "item", "Return the items"]
var items = 0
var bullets
var gun
var enemy_stats = {
	"Ghost" : {"Health" : 8, "Speed" : 600},
	"Enemy" : {"Health" : 5, "Speed" : 400},
	"Slime" : {"Health" : 3, "Speed" : 300}
}
