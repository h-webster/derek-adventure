extends Node

var sel_costume = 1
var sel_hair = 1

var completed = 0
var completed_people = []
var quest = 1
var last_enter = Vector2(0,0)
var person_quest = ""
var quests = ["Talk to grandma", "Go outside", "person", "Go back home"]
var items = 0
var items_collected = []
var bullets
var gun
var player
var item_quests = { #quest_name: display name, total items, node names, finish text
	"thirst": ["Items Collected: ", 3, ["Apple", "BottleWater", "Filter"], "Return back to Jamal"],
	"hungry": ["Items Collected: ", 4, ["Pants", "Meat", "Banana", "Shirt"], "Return back to Jeff"],
	"education" : ["Items Collected: ", 4, ["Book", "Paper", "Lamp", "Pencil"], "Return back to Joe"]
}
var enemy_stats = {
	"Ghost" : {"Health" : 8, "Speed" : 600},
	"Enemy" : {"Health" : 5, "Speed" : 400},
	"Slime" : {"Health" : 3, "Speed" : 300}
}
var sel_gun = 0
var unlocked_guns = 0
var guns = ["Pistol", "Shotgun", "RPG"]
var gun_stats = {
	"Pistol" : {"Speed" : 0.4, "DMG" : 2},
	"Shotgun" : {"Speed" : 0.3, "DMG" : 1},
	"RPG" : {"Speed" : 0.7, "DMG" : 10}
}
