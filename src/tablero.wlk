import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*


object tablero{
	
	//* Dimensiones del mapa
	const property alto = 12
	const property ancho = 15
	const property dimensionDeCelda = 75
	
	//* El alto del menú, para que no pise el reloj y las vidas
	const property altoMenu = 2

	var property imagenFondo="assets/img/fondos/tornaviasConBarra.png"

	//* Configuración de dimensiones y fondo
	method configurar(){
		game.width(ancho)
  		game.height(alto)
		game.cellSize(dimensionDeCelda)
  		//game.boardGround(imagenFondo)
	}

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


