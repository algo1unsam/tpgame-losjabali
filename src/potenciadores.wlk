import wollok.game.*
import guardia.*
import tablero.*

class Trampa {
	const property image = 'assets/img/utilidades/trampa.png'
	const property esEnemigo=false
	const posicionInicialY = game.height()-1
	const posicionInicialX = 1
	const posicionInicial = game.at(posicionInicialX,posicionInicialY)
	var property position = posicionInicial
	
	method colocar(){
		const nuevaPosicion = game.at(guardia.direccionX(),guardia.position().y())
		if(self.posicionValida(nuevaPosicion)){
			position = nuevaPosicion
			trampas.restarTrampa(self)
		}
		
	}
	method sePuedeColocar(nuevaPosicion) = tablero.posicionValida(nuevaPosicion) && self.posicionValida(nuevaPosicion)
	
	method posicionValida(nuevaPosicion) =  !game.allVisuals().any{visual=>visual==game.getObjectsIn(game.at(nuevaPosicion.x(),nuevaPosicion.y()))}
	
	method atrapaAlEnemigo(enemigo){
		if(enemigo.esEnemigo()){
			guardia.atrapaAlEnemigo(enemigo)
		 	self.levantarse()		
		}
	}
	method levantarse(){
		position = posicionInicial
		//game.removeVisual(self)
		//game.addVisualIn(self,posicionInicial)
		trampas.recojerTrampa(self)
	}
}


object trampas{
	const property cantidadDeTrampas = 3
	const property trampas=[]
	const property colocadas=[]
	//var property trampasRestantes = self.cantidadDeTrampas()
	method trampasRestantes() = cantidadDeTrampas - colocadas.size()
	
	method crear(){
		cantidadDeTrampas.times({i => trampas.add(new Trampa(posicionInicialX = i+3))})
	}
	method mostrar(){
		trampas.forEach({trampa=>game.addVisual(trampa)})	
	}
	method colocar(){
		if(self.trampasRestantes()>0){
			trampas.get(self.trampasRestantes()-1).colocar()	
			//trampas.last().colocar()
		}
	}
	method restarTrampa(trampa){
		//trampasRestantes-=1
		colocadas.add(trampa)
	}
	method recojerTrampa(trampa){
		//trampasRestantes+=1
		colocadas.remove(trampa)
	}
	
	method recojerTodas(){
		trampas.forEach{trampa=>trampa.levantarse()}
		colocadas.clear()
		//trampasRestantes = self.cantidadDeTrampas()
	}
	


}