import wollok.game.*
import juego.*
import menus.*
import guardia.*


object teclado {

	method configurarTeclasMenuInicial() {		
		// Tecla Finalizar Juego
		keyboard.alt().onPressDo({ juego.finalizarJuego()})
	}

	method configurarTeclaContinuar() {
		// Tecla Inicio Juego
		keyboard.space().onPressDo({ juego.iniciar()})
	}

	method configurarTeclasMenuFinal() {
		// Tecla Menu Inicial
		keyboard.space().onPressDo({ juego.iniciar()})
		// Tecla Finalizar Juego
		keyboard.alt().onPressDo({ juego.finalizarJuego()})
	}

	method configurarTeclasPersonajes() {
		// Teclas Izquierda
		keyboard.left().onPressDo{ guardia.mover(izquierda)}
		// Teclas Derecha
		keyboard.right().onPressDo{ guardia.mover(derecha)}
		//Tecla arriba
		keyboard.up().onPressDo{ guardia.mover(arriba)}
		//Tecla abajo
		keyboard.down().onPressDo{ guardia.mover(abajo)}
		// Teclas de Accion
	}
}
