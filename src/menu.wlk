
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
		game.addVisual(opcionMusica)
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{self.accionar()} 
		keyboard.space().onPressDo{game.stop()}
		
	}
	
	method empezar(){
		tablero.configurar()
		self.configurar()
		
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
	const posicionesY= [5,3,1]
 	var property numero=0

 	method image()="static/img/personajes/jabaliDer.png"
	
	method subir(){
		numero=0.max(numero-1)
	}
	
	method bajar(){
		numero=2.min(numero+1)
	}	
	
	method position(){
		return game.at(2, posicionesY.get(numero))
	}
	
	method opcion()= numero

	method inhabilitar(){
		posicionesY.clear()
		posicionesY.add(3)
		posicionesY.add(3)
		posicionesY.add(3)
	}
	method rehabilitar(){
		posicionesY.clear()
		posicionesY.add(5)
		posicionesY.add(3)
		posicionesY.add(1)
		numero=1
	}

}

class OpcionesMenu{
	var property posicionX = 4
	var property posicionY = 0
	var property position = game.at(posicionX,posicionY)
	var property image
	method iniciar(){		
		position=game.origin()
	}
		
	method initialize(){
		game.addVisual(self)
	}
}
object inicio inherits OpcionesMenu(image="static/img/menu/cartelIniciar.png",posicionY=5){
	method accion(){
		game.clear()
		juego.configurar()
		juego.iniciar()
	}
}
object instrucciones inherits OpcionesMenu(image="static/img/menu/cartelInstrucciones.png",posicionY=3){
	var mostrado = false
	
	method accion(){
		
		mostrado = !mostrado
		if(mostrado){		
			image = "static/img/menu/instrucciones.png"
			position = game.at(2, 1)
			salir.position(game.at(-5,-5))
			flecha.inhabilitar()
			juegoMenu.inhabilitarOpciones()
		}else{
			position = game.at(4, 3)
			image="static/img/menu/cartelInstrucciones.png"
			salir.position(game.at(4, 1))
			flecha.rehabilitar()
			juegoMenu.rehabilitarOpciones()
		}

	}

	
}
	object salir inherits OpcionesMenu(image="static/img/menu/cartelSalir.png", posicionY=1){
	method accion(){
		game.stop()
	}

}

object opcionMusica{

	method position() = game.at(game.width()-2,game.height()-1)
	
	method text() = "Pausar Musica P  Reanudar R "
	method textColor() = 'F80000'
}
