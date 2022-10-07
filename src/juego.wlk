import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import tablero.*

object juego {
	
	// Jabalies del juego
	var property jabalies = [jaba1,jaba2,jaba3,jaba4]
	// Nivel del juego
	var property nivel = 1
	
	var property frecuenciaDeMovimiento = 100/nivel
	
//* ##########################################
//* ##### FUNCIONES DE CONTROL DEL JUEGO #####
//* ##########################################
	
	// 1- Configura el ancho, alto, tamaño de celda, título y fondo 
	method configurar(){
		tablero.configurar()
  		
  		game.title("Atrapa El Jabali ")	
	}
	
	// 2- Inicia el juego
	method iniciar(){
		
		self.iniciarNivel()
		game.start()
	}
	
	// 3- Inicia nivel nuevo
	method iniciarNivel(){
		//* 3.1-  Limpia el tablero
		tablero.limpiarTablero()

		//* 3.2- Agrega al guardia
		tablero.agregarPersonajeMobible(guardia)

		//* 3.3- Inicia el reloj
		reloj.iniciar()

		//* 3.4- Crea las vidas
		vidas.crearCorazones()
		//* 3.5- Limpia el array de los jabalís atrapados por el guardia
		guardia.atrapados().clear()
		
		//* 3.5- Crea los jabalies 
		self.crearJabalies()
		
		//* 3.6-  Cada 100 ms, el Jabalí se mueve
		game.onTick(self.frecuenciaDeMovimiento(),"El jabali se mueve",{self.moverJabalies()})
		
		//* 3.7- Cuando el guardia colisiona con los jabalí, le avisa al juego que un jabalí es atrapado
		game.onCollideDo(guardia,{jabali => self.unJabaliEsAtrapado(jabali)})
		
		//* 3.8- Si el tiempo se agota, se pierde el juego
		game.onTick(100,"Chequear tiempo",{self.chequearTiempo()})

	}
	
	//* 4- Es ejecutado cuando se atrapa un Jabali
	method unJabaliEsAtrapado(jabali){
		//* 4.1- El guardia atrapa al jabali
		guardia.atrapaAlJabali(jabali)
		//* 4.2-  Chequea si todos los Jabali estan atrapados
		if(self.todosAtrapados()){
			//* 4.2.1- Si lo están, sube de nivel
			nivel += 1

			//* 4.2.2- Chequea si se llegó al nivel 4
			if (nivel > 4){
				//* - Si supera el nivel 4, ganó el juego
				self.ganar()
			}else{
				//* - Sino, inicia un nuevo nivel
				self.iniciarNivel()
			}
		}
	}

	//* 5- Chequea el tiempo
	method chequearTiempo(){
		if (reloj.tiempo() <= 0){
		//* 5.1-  Si el reloj llegó a cero chequea cuantas vidas tiene
			if(vidas.chequearVidas()){
				//* 5.1.1-  Si aún tiene vidas, reinicia el reloj y pierde una vida
				game.removeVisual(reloj)
				reloj.iniciar()
				vidas.perderVida()			
			}else{				
				//* 5.1.2- Si no tiene vidas. pierde
				self.perder()
			}
		}
	}

	//* 6 - Perder
	method perder(){
		//* Retorna 
		self.posicionFinal()
		// Muestra mensaje
		game.say(guardia,'NOOOOO')
	}

	//* 7- Reinicializa la posición del guardia
	method posicionFinal(){
		// Limpia el mapa
		game.clear()
		// Lleva al guardia al centro
		game.addVisualIn(guardia,game.center())
	}
	


	
	//* 8- Lo que sucede cuando se gana
	method ganar(){
		self.posicionFinal()
		// Muestra mensaje
		game.say(guardia,'VAMOOOO')
	}
	

	
//* #############################################
//* ##### FUNCIONES DE CONTROL DEL JABALIES #####
//* #############################################
	
	// 3.1- Spawnea los jabalies en el mapa
	method crearJabalies(){
		// Reinicia la posición de los Jabalí
		jabalies.take(nivel).forEach({jabali => jabali.resetearPosicion()})
		
		// Los muestra
		jabalies.take(nivel).forEach({jabali => game.addVisual(jabali)})
	}
	
	// 3.2- Mueve los jabalies
	method moverJabalies(){ 
		jabalies.take(nivel).forEach({jabali => jabali.mover()})
	}
	
	
	// 3.3.1- Chequea si están todos los jabalies atrapados
	method todosAtrapados(){
		// Ordena los Jabali por ID
		guardia.ordenarJabalies()
		const idsOrdenados = guardia.atrapados().map{jabali=>jabali.id()}
		
		const todosLosJabalies = self.jabalies().take(nivel).map{jabali=>jabali.id()}
		 
		return idsOrdenados == todosLosJabalies
	}
}