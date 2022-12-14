import wollok.game.*
import juego.*
import musica.*

//* ##########################################
//* ###### FUNCIONES DE VIDAS DEL JUEGO ######
//* ##########################################

class Corazon{
	
	// ID del corazón
	const property id = 0
	const property esEnemigo = false
	//* Determina si el corazón está o no lleno
	var property lleno = true
	
	//* Posición en X e Y del corazón
	var property posicionX = 0
	const posicionY = game.height()-1
	
	
	//* Imagen y getter del corazón que representa la vida
	var image = "assets/img/utilidades/corazonLleno.png" 
	method image() = image

	//* Posición
	method position() = game.at(posicionX,posicionY)
	
	//* Cambia la imagen del corazón por una de corazón vacío
	method vaciarCorazon(){
		image = "assets/img/utilidades/corazonVacio.png"
		lleno=false
	}

	//* Cambia la imagen del corazón por una de corazón lleno	
	method llenarCorazon(){
		image = "assets/img/corazonLleno.jpeg"
		lleno=true
	}
}
//* Objeto que maneja las vidas
object vidas{
	const cantidadDeVidas = 3
	const vidas=[]
	
	method perderVida(){
		vidas.filter({vida=>vida.lleno()}).last().vaciarCorazon()
	}
	
	method crearVidas(){
		cantidadDeVidas.times({i => vidas.add(new Corazon(posicionX = i-1))})
	}
	
	method mostrarCorazones(){
		vidas.forEach({vida=>game.addVisual(vida)})	
	}
	
	method chequearVidas() = vidas.any({vida=>vida.lleno()})
}





//* ###########################################################################
//* ######################### FUNCIONES DE CONTADORES #########################
//* ###########################################################################

class Contador{
	
	var property cantidadInicial = 1
	var property cantidad = cantidadInicial
	var property posicionX = game.width()-2
	var property posicionY = game.height()-1
	var property posicion = game.at(posicionX,posicionY)
	const property esEnemigo = false
	//* Función que toma Wollok para cargar el tiempo
	method text() = cantidad.toString()
	//* Función que toma Wollok para cambair el color del texto
	method textColor() = 'f80000'

	//* Manera en la que va evolucionando el contador
	method avanzar() {
		cantidad -= 1
	}
	method chequearEstado() {}
	method reiniciar(){	cantidad = cantidadInicial }
	//* Inicia el contador
	method iniciar(){
		self.mostrar()
	}
	method mostrar(){ game.addVisualIn(self,posicion) }
	
	//* Detiene el contador
	method detener(){ game.removeTickEvent("contador") }
	method quitar(){ game.removeVisual(self) }
}

//* #############################
//* ########### RELOJ ###########
//* #############################
object reloj inherits Contador{
	override method avanzar(){
		super()
		self.chequearEstado()
	}
	//* 5- Chequea el tiempo
	override method chequearEstado(){
		if (self.cantidad() <= 0){
		//* 1-  Si el reloj llegó a cero chequea cuantas vidas tiene
		//self.avanzar()
			if(vidas.chequearVidas()){
				//* 1.1-  Si aún tiene vidas, reinicia el reloj totalmente y pierde una vida
				vidas.perderVida()
				self.reiniciar()			
			}else{				
				//* 1.2- Si no tiene vidas. pierde
				musica.reproducirGrito()
				juego.terminarJuego()
			}
		}
	}
	method agregarTiempo(){
		if ((cantidad+2) <=cantidadInicial){
			cantidad += 2
			}
			else cantidad = cantidadInicial
		
	}
}

//* ##############################
//* ########### PUNTOS ###########
//* ##############################

object puntos inherits Contador(posicionX = game.width()/2,cantidadInicial = 0) {
	//*1-  Hace que los puntos sean crecientes
	override method avanzar() {
		cantidad += 20
	}
}







