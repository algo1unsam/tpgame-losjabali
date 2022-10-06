import wollok.game.*
import teclado.*
/* 
//SE CREA UNA CLASE PARA PODEER AGREGAR LO ELEMENTOS AL MENU 
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
//ELEMENTOS DE TODOS LOS MENUS
object title inherits ElementoVisible(image = "ATRAPA EL JABALI.png", position = game.at(0, game.height()).down(5)) {

}

object start inherits ElementoVisible(image = "start.png", position = game.at(0, game.height()).down(8)) {

}

object keys inherits ElementoVisible(image = "keys.png", position = game.at(0, game.height()).down(8)) {

}

object gameOver inherits ElementoVisible(image = "game_over.png", position = game.at(0, game.height()).down(5)) {

}

object restart inherits ElementoVisible(image = "restart.png", position = gameOver.position().down(8)) {

}

object exit inherits ElementoVisible(image = "exit.png", position = start.position().down(1)) {

}

//CLASE MENU GENERAL
class Menu {

	method agregarOpciones()

	method iniciar() {
		self.agregarOpciones()
	}

}
//MENU INICIAL
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
//IDEA MIA CREAR UN MENU SIGUIENTE PARA QUE TE IDIQUE COMO SE JUEGA
//NO SERIA UN MENU SINO UNA PANTLLA INTERMEDIA PERO BUENO.(QUEDA EN DUDA)
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
//MENU CUANDO TERMINA EL JUEGO PARA QUE TE DEJE HACER UN RESTART
// O PARA QUE TE DEJE HACER EXIT 
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
FIXME: HAY QUE CORREGIR LOS NOMBRES DE LOS METODOS, NO COINCIDEN CON LOS DECLARADOS EN ESTE JUEGO. ESTA ROMPIENDO POR ESO */