//* Importaciones
import wollok.game.*
import juego.*
import tablero.*
import guardia.*

class Jabali{

	//* Inicia la posición del Jabalí en aleatoria, también se usa en inglés porque WollokGame lo consume
	var property position = tablero.posicionAleatoria()
	var property atrapado = false
	var property imgDer = "static/img/personajes/jabaliDer.png"
	var property imgIzq = "static/img/personajes/jabaliIzq.png"
	
	var property image = "static/img/personajes/jabaliIzq.png"
	
	//* Imagen del Jabalí, el método es en inglés porque lo usa Wollok Game desde el método game.addVisual(jabali)
	//method image() = imagen

	//* Reestablece a aleatoria la posición del Jabalí
	method resetearPosicion(){
		position = tablero.posicionAleatoria()
	}
	
	// Método que mueve al Jabalí de lugar
	method mover(){
		// 1- Genera una nueva posición aleatoria entre (-1,-1) y (1,1) en los ejes (x,y)
		const nuevoMovimiento = game.at(position.x() + (-1).randomUpTo(1),position.y() + (-1).randomUpTo(1))
		
		
		// 2- Chequea si el próximo movimiento es adentro del mapa
		if (tablero.posicionValida(nuevoMovimiento)){
			// Cambia la imagen dependiendo hacia donde se mueve el jabalí
			image = if(nuevoMovimiento.x()>position.x()) self.imgDer() else self.imgIzq()
			
			// 2.1- Si se mueve, reemplaza la posición del Jabalí por el nuevo movimiento
			position = nuevoMovimiento
		}else{
			// 2.2- Si la posición no es correcta, vuelve a ejecutar la función hasta que haya una posición correcta
			self.mover()
		} 
	}
	method estaAtrapado() = guardia.atrapados().contains(self)
}



//* ####################################################
//* ####### FUNCIONES DE CONTROL DEL NIVEL #############
//* ####################################################

class Nivel{
	var property jabalies = []
	var property nroNivel
	var property frecuenciaDeMovimiento = 100/nroNivel
	
	
	method initialize(){
		self.limpiarJabalies()
		self.crearJabalies()
		self.moverJabalies()
	}
	
	method limpiarJabalies(){
		self.jabalies().clear()
		guardia.atrapados().clear()
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
			juego.iniciarNivel()
		}		
	}
}
