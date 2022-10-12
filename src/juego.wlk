import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import tablero.*


object juego {
	
	// Nivel del juego
	var property nroNivel = 1
	//var property nivelMaximo = 4
	
	
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
		
		//* 2.1- Configura el inicio del nivel
		self.iniciarNivel()
		
		//* 2.2- Lanza el juego
		game.start()
	}
	
	// 3- Inicia nivel nuevo
	method iniciarNivel(){
		const nivel = new Nivel(nroNivel = nroNivel)
		//* 3.1-  Limpia el tablero
		tablero.limpiarTablero()
		
		nivel.limpiarJabalies()
		nivel.crearJabalies()
		nivel.moverJabalies()

		//* 3.2- Agrega al guardia
		tablero.agregarPersonajeMobible(guardia)

		//* 3.3- Configura las teclas del guardia para que el guardia mire hacia donde se dirige 
		guardia.configurarTeclas()

		//* 3.4- Muestra los contadores de puntos y el reloj
		reloj.reiniciar()
		reloj.iniciar()
		puntos.iniciar()

		//* 3.5- Muestra las vidas
		vidas.mostrarCorazones()

		//* 3.6- Limpia el array de los jabalís atrapados por el guardia
		guardia.limpiarJabalies()
					
		//* 3.9- Cada un determinado tiempo, el Jabalí se mueve
		game.onTick(nivel.frecuenciaDeMovimiento(),"El jabali se mueve",{nivel.moverJabalies()})
		
		//* 3.10- Cuando el guardia colisiona con los jabalí, le avisa al juego que un jabalí es atrapado
		game.onCollideDo(guardia,{jabali => nivel.unJabaliEsAtrapado(jabali)})
		
		//* 3.11- Si el tiempo se agota, chequea el tiempo y las vidas
		game.onTick(1000,"Chequear tiempo",{reloj.chequearTiempo()})

	}

	


	
	//* 5- Lo que sucede cuando se gana
	method ganar(){
		guardia.restablecerPosicion()
		// Muestra mensaje
		game.say(guardia,'VAMOOOO CHEEEEE')
	}
	
	//* 6- Perder
	method perder(){
		//* Retorna 
		guardia.restablecerPosicion()
		// Muestra mensaje
		game.say(guardia,'NOOOOO')
	}
	
	//* 7- Subir de nivel
	method subirNivel(){
		nroNivel+=1
	}
	
}