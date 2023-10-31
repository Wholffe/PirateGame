extends Node

var redDiamonds = 0
var goldCoins = 0

enum projectileTypes {CANNON, TOTEM}

func playerDamage(value):
	print("player hit: " + str(value))
	
func debugShowValue():
	print("RED DIAMONDS: " + str(redDiamonds) + " Gold: " + str(goldCoins))
	
func addRedDiamonds():
	redDiamonds += 1

func removeRedDiamonds():
	redDiamonds -= 1
	
func addColdCoin():
	goldCoins += 1

func removeColdCoin():
	goldCoins -= 1
	
