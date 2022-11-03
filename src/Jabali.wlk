import wollok.game.*
import juego.*
import tablero.*
import guardia.*

class Enemigo{
	//* Inicia la posición del Jabalí en aleatoria, también se usa en inglés porque WollokGame lo consume
	const property esEnemigo = true
	var property position = tablero.posicionAleatoria()
	var property atrapado = false
	var property imgDer
	var property imgIzq
	var property image
	
	//* Reestablece a aleatoria la posición del Enemigo
	method resetearPosicion(){
		const nuevaPosicion = tablero.posicionAleatoria()
		if (nuevaPosicion != position){
			position = nuevaPosicion
		}
		else{
			self.resetearPosicion()
		}
		
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
		}
		else{
			// 2.2- Si la posición no es correcta, vuelve a ejecutar la función hasta que haya una posición correcta
			self.mover()
		} 
	}
	method estaAtrapado() = guardia.atrapados().contains(self)
}

class Jabali inherits Enemigo{
	method initialize(){
		imgDer = "assets/img/personajes/jabaliDer.png"
		imgIzq = "assets/img/personajes/jabaliIzq.png"
		image = "assets/img/personajes/jabaliIzq.png"
	}
	method saltar(){} 		
}


class Rata inherits Enemigo{
	method initialize(){
		imgDer = "assets/img/personajes/rataDer.png"
		imgIzq = "assets/img/personajes/rataIzq.png"
		image = "assets/img/personajes/rataIzq.png"
	}
	method saltar(){
		const nuevoMovimiento = game.at(position.x() + (-3).randomUpTo(3),position.y() + (-3).randomUpTo(3))
		if (tablero.posicionValida(nuevoMovimiento)){
			image = if(nuevoMovimiento.x()>position.x()) self.imgDer() else self.imgIzq()	
			position = nuevoMovimiento
		}
		else{
			self.mover()		
		}
	}
}
