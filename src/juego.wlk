import wollok.game.*
import guardia.*
import jabali.*
	
object juego {
	method configurar(){
		game.width(25)
  		game.height(20)
  		game.cellSize(40)
  		game.title("Atrapa El Jabali ")	
  		game.boardGround("static/img/tornavias.png")
  		game.addVisual(jabali)
  		game.addVisualCharacterIn(guardia, game.center())
  		
	}
	method iniciar(){
		game.onTick(300,"El jabali se mueve",{jabali.move()})
		game.onCollideDo(guardia,{juego => self.terminar()})
		game.start()
	}
	
	method posicionAleatoria() = game.at(
		0.randomUpTo(game.width()),
		0.randomUpTo(game.height())
	)
	
	method terminar(){
		game.clear()
		game.addVisualIn(guardia,game.center())
		game.say(guardia,'oops')
	}
}
