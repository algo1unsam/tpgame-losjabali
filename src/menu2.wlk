import wollok.game.*
import juego.*


object juegoMenu{
	const property opciones=[juego,instrucciones,salir] //opciones que tiene el menu
// 	const musicaMenu=game.sound("")
//	const musicaOpciones=game.sound("")
	
	method configurar(){
		game.boardGround("assets/menu.png") 
		game.addVisual(flecha)
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{self.cambiar(flecha.opcion())} 
		keyboard.backspace().onPressDo{game.stop()} 
		//abre la opcion del menu en el que está parada la flecha
	}
	
	method empezar(){
		self.configurar()
//		musicaMenu.shouldLoop(true)
//		game.schedule(500, { musicaMenu.play()})
//		game.schedule(0, { musicaOpciones.play() 
//							musicaOpciones.pause()})
		//empieza y pausa la musica de las opciones para poder usar resume
	}
	
	method cambiar(numero){
//		game.sound("musica/selection.mp3").play() 
		const opcion=self.opciones().get(numero) 
		//la opcion a la que cambio es  la posicion numero de opciones
		game.clear()
		game.addVisual(opcion)
//		musicaMenu.pause()
//		
//		musicaOpciones.resume()
		opcion.iniciar() 
		//aparece la imagen o empieza el juego
		
		keyboard.shift().onPressDo{=>self.volverAlMenu(numero)
//								 	musicaOpciones.pause()
		} //apretar 'shift' para volver al menu, pausa la musica
	}
	
	method volverAlMenu(numero){
		const opcion=self.opciones().get(numero)
		opcion.parar()
		game.clear()
		self.configurar() //vuelve a poner la flecha y las configuraciones de teclas
//		game.sound("musica/selection.mp3").play()
//		musicaMenu.resume()
	}
}

object flecha{
	const posicionesY= [2,1,0]
 	var numero=0
 	
 	method image()="src/static/img/personajes/jabaliDer.png"
	
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
	//devuelve la opcion del menu dependiendo la posicion en la que está
}

class OpcionesMenu{
	var position=self.posicionInicial()
	var property image
	method position() = position
	method posicionInicial()=game.at(game.width(),game.height()) //para que no se vea
	method iniciar(){		
		position=game.origin()
	}
	method parar(){
		position=self.posicionInicial()
		//vuelvo a esconder
	}
}
const iniciar = new OpcionesMenu(image ="src/static/img/menu/cartelIniciar.png" )
const instrucciones = new OpcionesMenu(image="src/static/img/menu/cartelInstrucciones.png")
const salir = new OpcionesMenu(image="src/static/img/menu/cartelSalir.png")