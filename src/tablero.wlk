import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*


object tablero{
	//* Dimensiones del mapa
	const property alto = 20
	const property ancho = 25
	const property dimensionDeCelda = 40
	//* El alto del menú, para que no pise el reloj y las vidas
	const property altoMenu = 3

	//* Configuración de dimensiones y fondo
	method configurar(){
		game.width(self.ancho())
  		game.height(self.alto())
		game.cellSize(dimensionDeCelda)

  		game.boardGround("static/img/fondos/tornavias.png")
	}
	
	method limpiarTablero(){ game.clear() }

	//* - Devuelve true o false dependiendo de si la posición se ubica dentro o fuera del mapa
	method posicionValida(nuevaPosicion){
		const nuevaPosicionEnX = (nuevaPosicion.x().between(0, game.width()))
		const nuevaPosicionEnY = (nuevaPosicion.y().between(0,game.height()- altoMenu))
		
		return nuevaPosicionEnX and nuevaPosicionEnY 
	}
	
	method agregarPersonajeMobible(personajeMobible){
		game.addVisualCharacter(personajeMobible)
	}

	//* 3.1.1- Muestra una nueva posición aleatoria dentro del tablero
	method posicionAleatoria() = game.at(0.randomUpTo(game.width()),0.randomUpTo(game.height() - altoMenu))
	
}


