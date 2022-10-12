import wollok.game.*
import juego.*
import tablero.*
import guardia.*

class Jabali{

	//* Inicia la posición del Jabalí en aleatoria, también se usa en inglés porque WollokGame lo consume
	var property position = tablero.posicionAleatoria()
	var property atrapado = false
	var property imgDer = "static/img/personajes/jabaliDer.png"
	var property imgIzq = "static/img/personajes/jabaliIzq.png"
	
	var property image = "static/img/personajes/jabaliIzq.png"
	
	//* Imagen del Jabalí, el método es en inglés porque lo usa Wollok Game desde el método game.addVisual(jabali)
	//method image() = imagen

	//* Reestablece a aleatoria la posición del Jabalí
	method resetearPosicion(){
		position = tablero.posicionAleatoria()
	}
	
	// Método que mueve al Jabalí de lugar
	method mover(){
		// 1- Genera una nueva posición aleatoria entre (-1,-1) y (1,1) en los ejes (x,y)
		const nuevoMovimiento = game.at(position.x() + (-1).randomUpTo(1),position.y() + (-1).randomUpTo(1))
		
		
		// 2- Chequea si el próximo movimiento es adentro del mapa
		if (tablero.posicionValida(nuevoMovimiento)){
			// Cambia la imagen dependiendo hacia donde se mueve el jabalí
			image = if(nuevoMovimiento.x()>position.x()) self.imgDer() else self.imgIzq()
			
			// 2.1- Si se mueve, reemplaza la posición del Jabalí por el nuevo movimiento
			position = nuevoMovimiento
		}else{
			// 2.2- Si la posición no es correcta, vuelve a ejecutar la función hasta que haya una posición correcta
			self.mover()
		} 
	}
	method estaAtrapado() = guardia.atrapados().contains(self)
}
