import wollok.game.*
import teclado.*

//* SE CREA UNA CLASE PARA PODEER AGREGAR LO ELEMENTOS AL MENU
//!!!	Agus: Me parece que esto estaría bueno pasarlo a utilidades.wlk, y ahí exportamos el método a TODOS los
//!!!		elementos  visibles como por ejemplo Jabalí, Guardia, Fondos, etc. Todos tienen img, position, mostrar, 
//!!!		remover, es código que podemos reducir y tiene sentido creo.

class ElementoVisible {

	var property image
	var property position

	method mostrar() {
		game.addVisual(self)
	}

	method remover() {
		game.removeVisual(self)
	}

}
//* ####################################
//* ### ELEMENTOS DE TODOS LOS MENUS ###
//* ####################################

//* Titulo del juego
//object titulo inherits ElementoVisible(image = "ATRAPA EL JABALI.png", position = game.at(0, game.height()).down(5)) {}

//* Botón de start
object iniciar inherits ElementoVisible(image = "static/menu/cartelIniciar.png", position = game.at(0, game.height()).down(8)) {}

//* Imagen de teclas
//object teclas inherits ElementoVisible(image = "keys.png", position = game.at(0, game.height()).down(8)) {}

//* Cartel de Game Over
//object juegoTerminado inherits ElementoVisible(image = "game_over.png", position = game.at(0, game.height()).down(5)) {}

//* Botón de Restart
//object reiniciar inherits ElementoVisible(image = "restart.png", position = gameOver.position().down(8)) {}

//* Botón de Exit
object salir inherits ElementoVisible(image = "static/menu/cartelSalir.png", position = iniciar.position().down(1)) {}

//* #############################
//* ### CLASE DE MENU GENERAL ###
//* #############################
class Menu {

	method agregarOpciones()

	method iniciar() { self.agregarOpciones() }

}

//* MENU INICIAL
object menuInicial inherits Menu {

	override method agregarOpciones() {
		// titulo.mostrar()
		iniciar.mostrar()
		salir.mostrar()
	}

	//override method iniciar() {
		//teclado.configurarTeclasMenuInicial()
	//}
}



//! #####################
//! ##### A DEFINIR #####
//! #####################

//* IDEA MIA CREAR UN MENU SIGUIENTE PARA QUE TE IDIQUE COMO SE JUEGA
//* NO SERIA UN MENU SINO UNA PANTLLA INTERMEDIA PERO BUENO.(QUEDA EN DUDA)
object menuInstruccionesTeclas inherits Menu {

	override method agregarOpciones() {
		//teclas.mostrar()
		iniciar.mostrar()
	}

	//override method iniciar() {
		//teclado.configurarTeclaContinuar()
	//}

}

//* MENU CUANDO TERMINA EL JUEGO PARA QUE TE DEJE HACER UN RESTART
//* O PARA QUE TE DEJE HACER EXIT 
object menuFinal inherits Menu {

	override method agregarOpciones() {
		//finJuego.mostrar()
		//restart.mostrar()
		salir.mostrar()
	}

	//override method iniciar() {
		//teclado.configurarTeclasMenuFinal()
	//}

}
//!	FIXME: HAY QUE CORREGIR LOS NOMBRES DE LOS METODOS, NO COINCIDEN CON LOS DECLARADOS EN ESTE JUEGO. ESTA ROMPIENDO POR ESO */