
import wollok.game.*
import juego.*
import tablero.*
import teclado.*

object menu{
	const property opciones=[inicio,instrucciones,salir] //opciones que tiene el menu
	var property image = "assets/img/fondos/fondoMenu.png"
	
	method mostrar(){
		game.addVisualIn(self,game.at(0,0)) 
		game.addVisual(flecha)
		game.addVisual(titulo)
		game.addVisual(inicio)
		game.addVisual(instrucciones)
		game.addVisual(salir)
		game.addVisual(textoConfiguracionTeclado)
		
	}
	method reiniciar(){
		teclado.configurarTeclasMenu()
		teclado.configurarTeclasGenerales()
		self.mostrar()
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

 	method image()="assets/img/personajes/jabaliDer.png"
	
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
object inicio inherits OpcionesMenu(image="assets/img/menu/cartelIniciar.png",posicionY=5){
	method accion(){
		game.clear()
		juego.iniciar()
	}
}
object instrucciones inherits OpcionesMenu(image="assets/img/menu/cartelInstrucciones.png",posicionY=3){
	var mostrado = false
	
	method accion(){
		
		mostrado = !mostrado
		if(mostrado){		
			image = "assets/img/menu/instrucciones.png"
			position = game.at(2, 1)
			salir.position(game.at(-5,-5))
			flecha.inhabilitar()
			menu.inhabilitarOpciones()
		}else{
			position = game.at(4, 3)
			image="assets/img/menu/cartelInstrucciones.png"
			salir.position(game.at(4, 1))
			flecha.rehabilitar()
			menu.rehabilitarOpciones()
		}

	}

	
}

object salir inherits OpcionesMenu(image="assets/img/menu/cartelSalir.png", posicionY=1){
	method accion(){
		game.stop()
	}
}

object textoConfiguracionTeclado{

	method position() = game.at(1,game.height()-1)
	
	method text() = "Musica: Pausar P | Reanudar R"
	method textColor() = 'F80000'
}

object titulo{
	method image() ="assets/img/menu/titulo.png"
	method position() = game.at(2,game.height()-3)
}
