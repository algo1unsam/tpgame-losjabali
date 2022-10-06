import wollok.game.*
import juego.*
	
class Jabali{
	//* Usamos ID para identificar que Jabalí está atrapado por el guardoa
	var property id = 0
	
	// Inicia la posición del Jabalí en aleatoria, también se usa en inglés porque WollokGame lo consume
	var property position = tablero.posicionAleatoria()
	
	//* Imagen del Jabalí, el método es en inglés porque lo usa Wollok Game desde el método game.addVisual(jabali)
	method image() = "static/img/jabali.png"
	
	// ### Métodos de movimiento ###
	
	// - Reestablece a aleatoria la posición del Jabalí
	method resetearPosicion(){
		position = tablero.posicionAleatoria()
	}
	

	
	// - Método que mueve al Jabalí de lugar
	method mover(){
		// 1- Genera una nueva posición aleatoria entre (-1,-1) y (1,1) en los ejes (x,y)
		const nuevoMovimiento = game.at(position.x() + (-1).randomUpTo(1),position.y() + (-1).randomUpTo(1))

		// 2- Chequea si el próximo movimiento es adentro del mapa
		if (tablero.posicionValida(nuevoMovimiento)){
			// 2.1- Si se mueve, reemplaza la posición del Jabalí por el nuevo movimiento
			position = nuevoMovimiento
		}else{
			// 2.2- Si la posición no es correcta, vuelve a ejecutar la función hasta que haya una posición correcta
			self.mover()
		} 
	}

}


// Creamos 4 jabalís para los 4 Niveles con sus id
const jaba1 = new Jabali(id = 1)
const jaba2 = new Jabali(id = 2)
const jaba3 = new Jabali(id = 3)
const jaba4 = new Jabali(id = 4)
