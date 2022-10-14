import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import tablero.*


object juego {
	
	// Nivel del juego
	var property nroNivel = 1
	var niveles = []
	
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
		reloj.reiniciar()
		guardia.atrapados().clear()
		niveles.add(new Nivel(nroNivel = nroNivel))
				
		//* 3.9- Cada un determinado tiempo, el nivel mueve a los jabalies
		game.onTick(niveles.last().frecuenciaDeMovimiento(),"El jabali se mueve",{niveles.last().moverJabalies()})
		
		//* 3.10- Cuando el guardia colisiona con los jabalí, le avisa al nivel que un jabalí fue atrapado
		game.onCollideDo(guardia,{jabali => niveles.last().unJabaliEsAtrapado(jabali)})
		
		//* 3.11- Si el tiempo se agota, chequea el tiempo y las vidas
		game.onTick(1000,"Chequear tiempo",{reloj.chequearTiempo()})
	}
	//* 6- Perder
	method terminarJuego(){
		//* Retorna 
		game.clear()
		game.addVisualIn(guardia,game.center())
		// Muestra mensaje
		game.say(guardia,puntos.cantidad().toString())
	}
	
	//* 7- Subir de nivel
	method subirNivel(){
		nroNivel+=1
		game.removeTickEvent("El jabali se mueve")
		game.removeTickEvent("Chequear tiempo")
		self.iniciarNivel()
	}
	
}


//* ####################################################
//* ####### FUNCIONES DE CONTROL DEL NIVEL #############
//* ####################################################

class Nivel{
	var property jabalies = []
	var property nroNivel
	var property frecuenciaDeMovimiento = 100/nroNivel
	
	method initialize(){
		self.crearJabalies()
		self.moverJabalies()
	}
	// 3.1- Spawnea los jabalies en el mapa
	method crearJabalies(){
		// Reinicia la posición de los Jabalies
		nroNivel.times({i => jabalies.add(new Jabali())})
		// Los spawnea
		jabalies.forEach({jabali => game.addVisual(jabali)})
	}
	// 3.2- Mueve los jabalies
	method moverJabalies(){ 
		jabalies.forEach({jabali => jabali.mover()})
	}
	// 3.3.1- Chequea si están todos los jabalies atrapados
	method todosAtrapados() = jabalies.all{jabali => jabali.estaAtrapado()}	
	
	//* 4- Es ejecutado cuando se atrapa un Jabali
	method unJabaliEsAtrapado(jabali){
		//* 4.1- El guardia atrapa al jabali
		guardia.atrapaAlJabali(jabali)
		//* 4.2-  Chequea si todos los Jabali estan atrapados
		self.chequearFinDeNivel()
	}
	// 4- Chequea si están todos los animales atrapados
	method chequearFinDeNivel(){
		if(self.todosAtrapados()){
			juego.subirNivel()
		}		
	}
}