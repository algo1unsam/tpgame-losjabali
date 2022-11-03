import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import tablero.*
import menu.*
import potenciadores.*
import musica.*
import teclado.*

object juego {
	
	// Nivel del juego
	var property nroNivel = 1
	const property niveles = []
	var property image = "assets/img/fondos/tornaviasConBarra.png"
	const property esEnemigo = false
//* ##########################################
//* ##### FUNCIONES DE CONTROL DEL JUEGO #####
//* ##########################################
	

	
	//* 1- Inicia el juego
	method iniciar(){
		game.clear()
		//musica.pausar()
		game.addVisualIn(self,game.at(0,0)) 
		//* Inicializa guardia
		tablero.agregarPersonajeMobible(guardia)
		teclado.configurarTeclasGuardia()
		teclado.configurarTeclasGenerales()
		guardia.equiparse()
		
		//* Inicializa vidas
		vidas.crearVidas()
		vidas.mostrarCorazones()
		
		//* Inicializa contadores
		reloj.iniciar()
		puntos.iniciar()
		
		self.iniciarNivel()
	}
	
	//* 2- Inicializa Las condiciones del nivel
	method iniciarNivel(){
		if(nroNivel>19){
			image = "assets/img/fondos/mordor.jpg"
		}
		var cuartoDeSegundo = 0
		
		
		reloj.reiniciar()
		
		guardia.atrapados().clear()
				
		//* 2.1- Cada un determinado tiempo, el nivel mueve a los enemigo niveles.last().frecuenciaDeMovimiento()
		game.onTick(250,"tiempo",{
			niveles.last().moverEnemigos()
			
			cuartoDeSegundo++
			if(cuartoDeSegundo==4){
				cuartoDeSegundo = 0
				reloj.avanzar()
				puntos.avanzar()
			}
		})
		
		//* 2.2- Cuando el guardia o las trampas colisionan con los jabalí, le avisa al nivel que un jabalí fue atrapado
		game.onCollideDo(guardia,{enemigo => niveles.last().unEnemigoEsAtrapado(guardia,enemigo)})
		trampas.trampas().forEach{trampa=> game.onCollideDo(trampa,{enemigo=>niveles.last().unEnemigoEsAtrapado(trampa,enemigo)})}
		
		niveles.add(new Nivel(nroNivel = nroNivel))
	}

	//* 3- Perder
	method terminarJuego(){
		//* Retorna 
		game.clear()
		game.addVisualIn(guardia,game.center())
		musica.reproducirGrito()
		
		//* Muestra mensaje
		game.say(guardia,puntos.cantidad().toString() + "    GAME OVER")
		
		//* Deja 5 segundos para que el jugador pueda ver el puntaje
		game.schedule(5000, {=>self.volverAlMenu()})
	}
	
	//* 7- Subir de nivel
	method subirNivel(){
		nroNivel+=1
		game.removeTickEvent("tiempo")
		trampas.recojerTodas()
		self.iniciarNivel()
	}
	
	method atraparTodosLosEnemigos(){
		niveles.last().enemigos().forEach{enemigo=>niveles.last().unEnemigoEsAtrapado(guardia,enemigo)}
	}
	
	method volverAlMenu(){
		//* Reinicia los niveles
		nroNivel = 1
		niveles.clear()

		game.clear()

		menu.reiniciar()
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
	method unEnemigoEsAtrapado(trampaOGuardia,enemigo){
		//* 4.1- El guardia atrapa al jabali
		trampaOGuardia.atrapaAlEnemigo(enemigo)		
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