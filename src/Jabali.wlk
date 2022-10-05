import wollok.game.*
import juego.*
	
class Jabali{
	var property id = 0
	var property position = juego.posicionAleatoria()
	method move(){
		var newPosition = game.at(position.x() + (-1).randomUpTo(1),position.y() + (-1).randomUpTo(1))
		if (self.isValidPosition(newPosition)){
			position = newPosition
		}
		else{
			self.move()
		}
		 
	}
	method isValidPosition(newPosition){
		return (newPosition.x().between(0, game.width())) and (newPosition.y().between(0,game.height()))
	}

	method image() = "static/img/jabali.png"
	method spawn(){
		position = juego.posicionAleatoria()
	}
}

const jaba1 = new Jabali(id = 1)
const jaba2 = new Jabali(id = 2)
const jaba3 = new Jabali(id = 3)
const jaba4 = new Jabali(id = 4)
