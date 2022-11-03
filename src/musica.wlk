import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import juego.*

object musica{
	const musicaMenu = game.sound("assets/sonidos/elJabali.mp3")
	method pausar(){
		if(!musicaMenu.paused()){
			musicaMenu.pause()
		}
	}
	method reproducir(){
		if(musicaMenu.paused()){
			musicaMenu.resume()
		}
	}
	method iniciar(){
		musicaMenu.shouldLoop()
		game.schedule(1000, {musicaMenu.play()})
	}
	
	method reproducirGrito(){
		game.sound("assets/sonidos/wilhelm.mp3").play()	
	}

}


