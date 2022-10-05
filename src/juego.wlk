import wollok.game.*
import guardia.*
import Jabali.*
	
object juego {
	var property jabalies = [jaba1,jaba2,jaba3,jaba4]
	var property nivel = 1
	method configurar(){
		game.width(25)
  		game.height(20)
  		game.cellSize(40)
  		game.title("Atrapa El Jabali ")	
  		game.boardGround("static/img/tornavias.png")
  		game.addVisualCharacterIn(guardia, game.center())
  		
	}
	method iniciar(){
		self.spawnJabali()
		game.onTick(100,"El jabali se mueve",{self.moverJabalies()})
		game.onCollideDo(guardia,{jabali => self.siguienteNivel(jabali)})
		game.start()
	}
	method iniciarNivel(){
		guardia.atrapados().clear()
		self.spawnJabali()
		game.onTick(100,"El jabali se mueve",{self.moverJabalies()})
		game.onCollideDo(guardia,{jabali => self.siguienteNivel(jabali)})
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
	method siguienteNivel(jabali){
		guardia.atrapaAlJabali(jabali)
		if(self.pasarNivel()){
			nivel += 1
			if (nivel > 4){
				self.terminar()
			}
			else{
				game.clear()
				game.addVisualCharacterIn(guardia, game.center())
				self.iniciarNivel()
			}
		}
	}
	method pasarNivel(){
		guardia.atrapados().sortBy({jabaA,jabaB => jabaA.id()<jabaB.id()})
		var idsOrdenados = guardia.atrapados().map{jabali=>jabali.id()}
		return idsOrdenados == self.jabalies().take(nivel).map{jabali=>jabali.id()}
	}
	method spawnJabali(){
		jabalies.take(nivel).forEach({jaba => jaba.spawn()})
		jabalies.take(nivel).forEach({jaba => game.addVisual(jaba)})
	}
	method moverJabalies(){
		jabalies.take(nivel).forEach({jaba => jaba.move()})
	}
}
