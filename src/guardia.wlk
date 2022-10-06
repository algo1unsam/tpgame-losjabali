import wollok.game.*
import juego.*

object guardia{
	
	var property atrapados = []
	var property position = game.center()
	
	method position(nuevaPosicion){
		if (tablero.posicionValida(nuevaPosicion)){
			position = nuevaPosicion
		} 
	}
	
	//* Imagen del Guardia, el método es en inglés porque lo usa Wollok Game desde el método addVisualCharacterIn(guardia, game.center())
	method image() = "static/img/guardia.png"
	
	// Agrega al Jabali al array de atrapados y lo remueve del mapa 
	method atrapaAlJabali(jabali){
		atrapados.add(jabali)
		game.removeVisual(jabali)
	}
	
	method ordenarJabalies(){
		atrapados.sortBy({jabaliA,jabaliB => jabaliA.id()<jabaliB.id()})
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
 
 






