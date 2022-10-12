import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import tablero.*


object juego {
	
	// Nivel del juego
	var property nroNivel = 1
	
//* ##########################################
//* ##### FUNCIONES DE CONTROL DEL JUEGO #####
//* ##########################################
	
	// 1- Configura el ancho, alto, tamaño de celda, título y fondo 
	method configurar(){
		
		tablero.configurar()

  		
  		//* Setea el tíulo
  		game.title("Atrapa El Jabali ")
  		//* Muestra el título	
  		game.title()
	}
	
	// 2- Inicia el juego
	method iniciar(){
		tablero.agregarPersonajeMobible(guardia)
		guardia.configurarTeclas()
		reloj.iniciar()
		puntos.iniciar()
		vidas.mostrarCorazones()
		//* 2.1- Configura el inicio del nivel
		self.iniciarNivel()
		
		//* 2.2- Lanza el juego
		game.start()

	}
	
	// 3- Inicia nivel nuevo
	method iniciarNivel(){
		const nivel = new Nivel(nroNivel = nroNivel)

		//* 3.4- Muestra los contadores de puntos y el reloj
		reloj.reiniciar()
				
		//* 3.9- Cada un determinado tiempo, el Jabalí se mueve
		game.onTick(nivel.frecuenciaDeMovimiento(),"El jabali se mueve",{nivel.moverJabalies()})
		
		//* 3.10- Cuando el guardia colisiona con los jabalí, le avisa al juego que un jabalí es atrapado
		game.onCollideDo(guardia,{jabali => nivel.unJabaliEsAtrapado(jabali)})
		
		//* 3.11- Si el tiempo se agota, chequea el tiempo y las vidas
		game.onTick(1000,"Chequear tiempo",{reloj.chequearTiempo()})

	}
	
	//* 6- Perder
	method terminarJuego(){
		//* Retorna 
		guardia.restablecerPosicion()
		// Muestra mensaje
		game.say(guardia,'NOOOOO')
	}
	
	//* 7- Subir de nivel
	method subirNivel(){
		nroNivel+=1
		game.removeTickEvent("El jabali se mueve")
		game.removeTickEvent("Chequear tiempo")
	}
	
}