import wollok.game.*

//* ##########################################
//* ###### FUNCIONES DE VIDAS DEL JUEGO ######
//* ##########################################

class Corazon{
	
	// ID del corazón
	const property id = 0
	
	//* Determina si el corazón está o no lleno
	var property lleno = true
	
	//* Posición en X e Y del corazón
	const posicionX = 1
	const posicionY = game.height()-1
	
	
	//* Imagen y getter del corazón que representa la vida
	var image = "static/img/utilidades/corazonLleno.png" 
	method image() = image

	//* Posición
	method position() = game.at(posicionX,posicionY)
	
	//* Cambia la imagen del corazón por una de corazón vacío
	method vaciarCorazon(){
		image = "static/img/utilidades/corazonVacio.png"
		lleno=false
	}

	//* Cambia la imagen del corazón por una de corazón lleno	
	method llenarCorazon(){
		image = "static/img/corazonLleno.png"
		lleno=true
	}
}

//* Definimos las 3 vidas
const vida1 = new Corazon()
const vida2 = new Corazon(id=1, posicionX=2)
const vida3 = new Corazon(id=2,posicionX=3)

//* Objeto que maneja las vidas
object vidas{

	const vidas=[vida1,vida2,vida3]
	
	method perderVida(){
		vidas.filter({vida=>vida.lleno()}).last().vaciarCorazon()
	}
	
	method crearCorazones(){
		vidas.forEach({vida=>game.addVisual(vida)})	
	}
	
	method chequearVidas() = vidas.any({vida=>vida.lleno()})
}

//* ##########################################
//* ###### FUNCIONES DE RELOJ DE JUEGO ######
//* ##########################################

object reloj{
	var property tiempo = 120
	
	method text() = tiempo.toString()
	method textColor() = 'ffffff'
	
	method size() = 4

	method pasarTiempo() {
		tiempo -= 1
	}
	method iniciar(){
		tiempo = 120
		game.addVisualIn(self,game.at(game.width()-2,game.height()-2))
		game.onTick(100,"tiempo",{self.pasarTiempo()})
	}
	method detener(){
		game.removeTickEvent("tiempo")
	}
}