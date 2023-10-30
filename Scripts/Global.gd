extends Node

var redDiamonds = 0
var goldCoins = 0

func debugShowValue():
	print("RED DIAMONDS: " + str(redDiamonds) + " Gold: " + str(goldCoins))
	
func addRedDiamonds():
	redDiamonds += 1
	debugShowValue()

func removeRedDiamonds():
	redDiamonds -= 1
	debugShowValue()
	
func addColdCoin():
	goldCoins += 1
	debugShowValue()

func removeColdCoin():
	goldCoins -= 1
	debugShowValue()
	
