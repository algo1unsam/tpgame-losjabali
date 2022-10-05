import wollok.game.*

object guardia{
	var adicionales = []
	var property atrapados = []
	method image() = "static/img/guardia.png"
	method recogerAdicional(adicional){
		// Recoge una trampa o un carrito, se agrega a su lista de adicionales
	}
	method usarAdicional(adicional){
		// Usar la trampa o el carrito, puede ser con la barra espaciadora, se remueve de su lista de adicionales
	}
	method atrapaAlJabali(jabali){
		atrapados.add(jabali)
		game.removeVisual(jabali) 
	}
}
 
 
 






