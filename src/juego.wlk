import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import tablero.*
import menu.*

object juego {
	
	// Nivel del juego
	var property nroNivel = 1
	const property niveles = []
	
//* ##########################################
//* ##### FUNCIONES DE CONTROL DEL JUEGO #####
//* ##########################################
	
	// 1- Configura el ancho, alto, tamaño de celda, título y fondo 
	method configurar(){
		tablero.configurar()
  		//* Setea el tíulo
  		game.title("Atrapa El Jabali ")
	}
	
	// 2- Inicia el juego
	method iniciar(){
		tablero.agregarPersonajeMobible(guardia)
		guardia.configurarTeclas()
		reloj.iniciar()
		puntos.iniciar()
		vidas.crearVidas()
		vidas.mostrarCorazones()
		//* 2.1- Configura el inicio del nivel
		self.iniciarNivel()

	}
	
	// 3- Inicia nivel nuevo
	method iniciarNivel(){
		var auxiliar = 0
		reloj.reiniciar()
		guardia.atrapados().clear()
		niveles.add(new Nivel(nroNivel = nroNivel))
				
		//* 3.9- Cada un determinado tiempo, el nivel mueve a los enemigo niveles.last().frecuenciaDeMovimiento()
		game.onTick(250,"tiempo",{
			niveles.last().moverEnemigos()
			
			auxiliar++
			if(auxiliar==4){
				auxiliar = 0
				reloj.avanzar()
				puntos.avanzar()
			}
		})
		
		//* 3.10- Cuando el guardia colisiona con los jabalí, le avisa al nivel que un jabalí fue atrapado
		game.onCollideDo(guardia,{enemigo => niveles.last().unEnemigoEsAtrapado(enemigo)})
	}
	//* 6- Perder
	method terminarJuego(){
		//* Retorna 
		game.clear()
		game.addVisualIn(guardia,game.center())
		soundProducer.play("assets/sonidos/wilhelm.mp3")
		// Muestra mensaje
		game.say(guardia,puntos.cantidad().toString() + "    GAME OVER")
		nroNivel = 1
		
		niveles.clear()
		game.schedule(3000, {=>juegoMenu.reiniciar()})
	}
	
	//* 7- Subir de nivel
	method subirNivel(){
		nroNivel+=1
		game.removeTickEvent("tiempo")
		self.iniciarNivel()
	}
	
}


//* ####################################################
//* ####### FUNCIONES DE CONTROL DEL NIVEL #############
//* ####################################################

class Nivel{
	var property enemigos = []
	var property nroNivel
	var property frecuenciaDeMovimiento = 500/nroNivel
	
	method initialize(){
		self.crearEnemigos()
		self.moverEnemigos()
	}
	// 3.1- Spawnea los jabalies en el mapa
	method crearEnemigos(){
		// Reinicia la posición de los Jabalies
		nroNivel.times({i => enemigos.add(new Jabali())})
		(nroNivel/3).times({i => enemigos.add(new Rata())})
		// Los spawnea
		enemigos.forEach({enemigo => game.addVisual(enemigo)})
	}
	// 3.2- Mueve los jabalies
	method moverEnemigos(){ 
		enemigos.forEach({enemigo => enemigo.mover()})
		enemigos.forEach({enemigo => enemigo.saltar()})
		
	}
	// 3.3.1- Chequea si están todos los jabalies atrapados
	method todosAtrapados() = enemigos.all{enemigo => enemigo.estaAtrapado()}	
	
	//* 4- Es ejecutado cuando se atrapa un Jabali
	method unEnemigoEsAtrapado(enemigo){
		//* 4.1- El guardia atrapa al jabali
		guardia.atrapaAlEnemigo(enemigo)
		//* 4.2-  Chequea si todos los Jabali estan atrapados
		self.chequearFinDeNivel()
		reloj.agregarTiempo()
	}
	// 4- Chequea si están todos los animales atrapados
	method chequearFinDeNivel(){
		if(self.todosAtrapados()){
			juego.subirNivel()
		}		
	}
}