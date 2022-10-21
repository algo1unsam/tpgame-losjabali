
import wollok.game.*
import juego.*
import tablero.*


object juegoMenu{
	const property opciones=[inicio,instrucciones,salir] //opciones que tiene el menu
	var property image = "static/img/fondos/fondoMenu.png" 
	method configurar(){
		game.addVisualIn(self,game.at(0,0)) 
		game.addVisual(flecha)
		game.addVisual(inicio)
		game.addVisual(instrucciones)
		game.addVisual(salir)
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{self.accionar()} 
		//keyboard.space().onPressDo(self.empezar())
		//keyboard.backspace().onPressDo{game.stop()} 
	}
	
	method empezar(){
		tablero.configurar()
		self.configurar()
		game.start()
		
	}
	method reiniciar(){
		self.configurar()
	}
	method accionar(){
		opciones.get(flecha.numero()).accion()
	}
	method inhabilitarOpciones(){
		opciones.clear()
		opciones.add(instrucciones)
		opciones.add(instrucciones)
		opciones.add(instrucciones)
	}
	method rehabilitarOpciones(){
		opciones.clear()
		opciones.add(inicio)
		opciones.add(instrucciones)
		opciones.add(salir)
	}
}
object flecha{
	const posicionesY= [7,4,1]
 	var property numero=0

 	method image()="static/img/personajes/jabaliDer.png"
	
	method subir(){
		numero=0.max(numero-1)
	}
	
	method bajar(){
		numero=2.min(numero+1)
	}	
	
	method position(){
		return game.at(3, posicionesY.get(numero))
	}
	
	method opcion()= numero

	method inhabilitar(){
		posicionesY.clear()
		posicionesY.add(4)
		posicionesY.add(4)
		posicionesY.add(4)
	}
	method rehabilitar(){
		posicionesY.clear()
		posicionesY.add(7)
		posicionesY.add(4)
		posicionesY.add(1)
		numero=1
	}

}

class OpcionesMenu{
	var property position
	var property image
	method iniciar(){		
		position=game.origin()
	}
		
	method initialize(){
		game.addVisual(self)
	}
}
object inicio inherits OpcionesMenu(image="static/img/menu/cartelIniciar.png",position = game.at(7, 7)){
	method accion(){
		game.clear()
		juego.configurar()
		juego.iniciar()
	}
}
object instrucciones inherits OpcionesMenu(image="static/img/menu/cartelInstrucciones.png",position = game.at(7, 4)){
	var mostrado = false
	
	method accion(){
		
		mostrado = !mostrado
		if(mostrado){		
			image = "static/img/menu/instrucciones.png"
			position = game.at(3, 2)
			salir.position(game.at(-5,-5))
			flecha.inhabilitar()
			juegoMenu.inhabilitarOpciones()
		}else{
			position = game.at(7, 4)
			image="static/img/menu/cartelInstrucciones.png"
			salir.position(game.at(7, 1))
			flecha.rehabilitar()
			juegoMenu.rehabilitarOpciones()
		}

	}

	
}
object salir inherits OpcionesMenu(image="static/img/menu/cartelSalir.png", position = game.at(7, 1)){
	method accion(){
		game.stop()
	}

}
object opcionMusica{

	method position() = game.at(22,19)
	
	method text() = "Pausar Musica P  Reanudar R "
	method textColor() = 'F80000'
}
