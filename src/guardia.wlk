import wollok.game.*
import juego.*
import tablero.*
import utilidades.*
import potenciadores.*
import teclado.*

object guardia{
	const property esEnemigo = false
	var property position = game.center()
	var property imagen = "assets/img/personajes/guardiaDer.png"
	var property miraDerecha = true
	//* Imagen del Guardia, el método es en inglés porque lo usa Wollok Game desde el método addVisualCharacterIn(guardia, game.center())
	method image() = imagen
	
	//* Chequea y cambia la posición del guardia
	method position(nuevaPosicion){
		if (tablero.posicionValida(nuevaPosicion)){
			position = nuevaPosicion
		} 
	}
	method posicion() = position
	
	method direccionX(){
		if(self.miraDerecha()){
			return self.position().x()+1
		}else{
			return self.position().x()-1
		}
	}
	
	method mirarIzquierda(){
		imagen="assets/img/personajes/guardiaIzq.png"
		miraDerecha=false
	}
	method mirarDerecha(){
		imagen="assets/img/personajes/guardiaDer.png"
		miraDerecha=true
	}
	
	method equiparse(){
		//2.times({i => trampas.add(new TrampaDeOsos(posicionInicial=game.at(game.height()-1,4+i)))})
		trampas.crear()
		trampas.mostrar()
	}
	method dejarTrampa(){
		trampas.colocar()
	}

	
//* #####################################################
//* ######## FUNCIONES DE LOS JABALIES ATRAPADOS ########
//* #####################################################

	// Agrega al Jabali al array de atrapados y lo remueve del mapa 
	method atrapaAlEnemigo(enemigo){
		if(enemigo.esEnemigo()){
			game.removeVisual(enemigo)
		}
			
	}
}

 
 






