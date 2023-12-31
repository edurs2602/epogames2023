extends Node

var PLAYER_SPEED = 200.0
var PLAYER_JUMP_VELOCITY = -300.0
var PLAYER_LIFE = 5
var PLAYER_DAMAGE = 2

var PLAYER_POWER_UPS = []

var player_on_level = 1
var resolution_level = 3

var POWER_UPS = [
	[
		["PLAYER_LIFE",-2],
		["PLAYER_SPEED",250]
	],
	[
		["PLAYER_SPEED",-150],
		["PLAYER_LIFE",3]
	],
	[
		["PLAYER_LIFE",-3],
		["PLAYER_DAMAGE",3]
	],
	[
		["PLAYER_JUMP_VELOCITY",100],
		["PLAYER_SPEED",100]
	],
	[
		["PLAYER_DAMAGE",-2],
		["PLAYER_LIFE",4]
	],
	[
		["PLAYER_DAMAGE",-2],
		["PLAYER_SPEED",300]
	],
	[
		["PLAYER_LIFE",-1],
		["PLAYER_JUMP_VELOCITY",-100]
	],
	[
		["PLAYER_DAMAGE",-1],
		["PLAYER_JUMP_VELOCITY",-200]
	],
	[
		["PLAYER_SPEED",-150],
		["PLAYER_DAMAGE",1]
	],
	[
		["PLAYER_SPEED",-100],
		["PLAYER_JUMP_VELOCITY",-150]
	],
	[
		["PLAYER_JUMP_VELOCITY",100],
		["PLAYER_LIFE",2]
	],
	[
		["PLAYER_JUMP_VELOCITY",100],
		["PLAYER_DAMAGE",2]
	],
]

