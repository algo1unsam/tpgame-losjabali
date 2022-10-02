import wollok.game.*
import juego.*
	
object jabali{
	var property position = juego.posicionAleatoria()
	method move(){
		position = game.at(position.x() + (-1).randomUpTo(1),position.y() + (-1).randomUpTo(1))
	}

	method image() = "static/img/jabali.png"
}