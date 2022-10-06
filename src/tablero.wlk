import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*


object tablero{
	const property alto = 20
	const property ancho = 25
	const property altoMenu = 3
	
	method configurar(){
		game.width(self.ancho())
  		game.height(self.alto())
  		game.boardGround("static/img/fondos/tornavias.png")
	}
	
	// 6- Devuelve true o false dependiendo de si la posición se ubica dentro o fuera del mapa
	method posicionValida(nuevaPosicion){
		const nuevaPosicionEnX = (nuevaPosicion.x().between(0, game.width()))
		const nuevaPosicionEnY = (nuevaPosicion.y().between(0,game.height()- altoMenu))
		return nuevaPosicionEnX and nuevaPosicionEnY 
	}
	
	// 3.1.1- Muestra una nueva posición aleatoria dentro del juego
	method posicionAleatoria() = game.at(0.randomUpTo(game.width()),0.randomUpTo(game.height()- altoMenu))
	
}


