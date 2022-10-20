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
		keyboard.backspace().onPressDo{game.stop()} 
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
	method accion(){
		
	}
}
object salir inherits OpcionesMenu(image="static/img/menu/cartelSalir.png", position = game.at(7, 1)){
	method accion(){
		game.stop()
	}
}