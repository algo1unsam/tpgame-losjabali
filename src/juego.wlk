import wollok.game.*
import guardia.*
import Jabali.*
	
object juego {
	
	// Jabalies del juego
	var property jabalies = [jaba1,jaba2,jaba3,jaba4]
	// Nivel del juego
	var property nivel = 1
	
// ##########################################
// ##### FUNCIONES DE CONTROL DEL JUEGO #####
// ##########################################
	
	// 1- Configura el ancho, alto, tamaño de celda, título y fondo 
	method configurar(){
		game.width(25)
  		game.height(20)
  		game.cellSize(40)
  		game.title("Atrapa El Jabali ")	
  		game.boardGround("static/img/tornavias.png")
  		
	}
	
	// 2- Inicia el juego
	method iniciar(){
		self.iniciarNivel()
		game.start()
	}
	
	// 3- Inicia nivel nuevo
	method iniciarNivel(){
		game.clear()
		game.addVisualCharacterIn(guardia, game.center())
			
		// Limpia el array de los jabalís atrapados por el guardia
		guardia.atrapados().clear()
		
		// Crea los jabalies 
		self.crearJabalies()
		
		// Cada 100 ms, el Jabalí se mueve
		game.onTick(100,"El jabali se mueve",{self.moverJabalies()})
		
		// Cuando el guardia colisiona con los jabalí, le avisa al juego que un jabalí es atrapado
		game.onCollideDo(guardia,{jabali => self.unJabaliEsAtrapado(jabali)})
	}
	
	// 3.3- Es ejecutado cuando se atrapa un Jabali
	method unJabaliEsAtrapado(jabali){
		// El guardia atrapa al Jabali
		guardia.atrapaAlJabali(jabali)
		
		// Chequea si todos los Jabali estan atrapados
		if(self.todosAtrapados()){
			// Si lo están, sube de nivel
			nivel += 1
			// Si supera el nivel 4, ganó el juego
			if (nivel > 4){
				self.ganar()
			}else{
				// Sino, inicia un nuevo nivel

				self.iniciarNivel()
			}
		}
	}
	
	// 4- Lo que sucede cuando se gana
	method ganar(){
		// Limpia el mapa
		game.clear()
		// Lleva al guardia al centro
		game.addVisualIn(guardia,game.center())
		// Muestra mensaje
		game.say(guardia,'VAMOOOO')
	}
	
// #############################################
// ##### FUNCIONES DE CONTROL DEL JABALIES #####
// #############################################
	
	// 3.1- Spawnea los jabalies en el mapa
	method crearJabalies(){
		// Reinicia la posición de los Jabalí
		jabalies.take(nivel).forEach({jabali => jabali.posicionAleatoria()})
		
		// Los muestra
		jabalies.take(nivel).forEach({jabali => game.addVisual(jabali)})
	}
	
	// 3.1.1- Muestra una nueva posición aleatoria dentro del juego
	method posicionAleatoria() = game.at(0.randomUpTo(game.width()),0.randomUpTo(game.height()))
	
	// 3.2- Mueve los jabalies
	method moverJabalies(){ 
		jabalies.take(nivel).forEach({jabali => jabali.mover()})
	}
	
	// 6- Devuelve true o false dependiendo de si la posición se ubica dentro o fuera del mapa
	method posicionValida(nuevaPosicion){
		const nuevaPosicionEnX = (nuevaPosicion.x().between(0, game.width()))
		const nuevaPosicionEnY = (nuevaPosicion.y().between(0,game.height()))
		return nuevaPosicionEnX and nuevaPosicionEnY 
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
