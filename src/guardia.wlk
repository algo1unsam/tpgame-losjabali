import wollok.game.*
import juego.*
import tablero.*

object guardia{
	
	var property atrapados = []
	
	var property position = game.center()
	
	var property imagen = "static/img/personajes/guardiaDer.png"
	
	//* Imagen del Guardia, el método es en inglés porque lo usa Wollok Game desde el método addVisualCharacterIn(guardia, game.center())
	method image() = imagen
	
	//* Chequea y cambia la posición del guardia
	method position(nuevaPosicion){
		if (tablero.posicionValida(nuevaPosicion)){
			position = nuevaPosicion
		} 
	}
	method configurarTeclas() {		

		keyboard.right().onPressDo({imagen="static/img/personajes/guardiaDer.png"})
		keyboard.left().onPressDo({imagen="static/img/personajes/guardiaIzq.png"})
	}
	
//* #####################################################
//* ######## FUNCIONES DE LOS JABALIES ATRAPADOS ########
//* #####################################################

	// Agrega al Jabali al array de atrapados y lo remueve del mapa 
	method atrapaAlEnemigo(enemigo){
		atrapados.add(enemigo)
		game.removeVisual(enemigo)
	}
}
 
 
 /* ### Próximas Features del Guardia ###
	//Array de objetos adicionales
	var adicionales = []
	method recogerAdicional(adicional){
		// Recoge una trampa o un carrito, se agrega a su lista de adicionales
	}
	method usarAdicional(adicional){
		// Usar la trampa o el carrito, puede ser con la barra espaciadora, se remueve de su lista de adicionales
	}
*/
 
 






