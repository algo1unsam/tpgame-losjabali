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

//* Fondo de pantalla
object titulo inherits ElementoVisible(image = "ATRAPA EL JABALI.png", position = game.at(0, game.height()).down(5)) {

}

//* Botón de start
object iniciar inherits ElementoVisible(image = "start.png", position = game.at(0, game.height()).down(8)) {

}

//* Imagen de teclas
object teclas inherits ElementoVisible(image = "keys.png", position = game.at(0, game.height()).down(8)) {

}

//* Cartel de Game Over
object juegoTerminado inherits ElementoVisible(image = "game_over.png", position = game.at(0, game.height()).down(5)) {

}

//* Botón de Restart
object reiniciar inherits ElementoVisible(image = "restart.png", position = gameOver.position().down(8)) {

}
//* Botón de Exit
object salir inherits ElementoVisible(image = "exit.png", position = start.position().down(1)) {

}

//* #############################
//* ### CLASE DE MENU GENERAL ###
//* #############################
class Menu {

	method agregarOpciones()

	method iniciar() {
		self.agregarOpciones()
	}

}

//* MENU INICIAL
object menuInicial inherits Menu {

	override method agregarOpciones() {
		title.mostrar()
		start.mostrar()
		exit.mostrar()
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuInicial()
	}
}



//! #####################
//! ##### A DEFINIR #####
//! #####################

//* IDEA MIA CREAR UN MENU SIGUIENTE PARA QUE TE IDIQUE COMO SE JUEGA
//* NO SERIA UN MENU SINO UNA PANTLLA INTERMEDIA PERO BUENO.(QUEDA EN DUDA)
object menuInstruccionesTeclas inherits Menu {

	override method agregarOpciones() {
		keys.mostrar()
		start.mostrar()
	}

	override method iniciar() {
		super()
		teclado.configurarTeclaContinuar()
	}

}

//* MENU CUANDO TERMINA EL JUEGO PARA QUE TE DEJE HACER UN RESTART
//* O PARA QUE TE DEJE HACER EXIT 
object menuFinal inherits Menu {

	override method agregarOpciones() {
		gameOver.mostrar()
		restart.mostrar()
		exit.mostrar()
	}

	override method iniciar() {
		super()
		teclado.configurarTeclasMenuFinal()
	}

}
//!	FIXME: HAY QUE CORREGIR LOS NOMBRES DE LOS METODOS, NO COINCIDEN CON LOS DECLARADOS EN ESTE JUEGO. ESTA ROMPIENDO POR ESO */