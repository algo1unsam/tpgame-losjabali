import wollok.game.*
import guardia.*
import Jabali.*
import utilidades.*
import juego.*
import musica.*
import menu.*

object teclado{
	
	method configurarTeclasMenu(){
		keyboard.up().onPressDo{flecha.subir()}
		keyboard.down().onPressDo{flecha.bajar()}
		keyboard.enter().onPressDo{menu.accionar()} 
	}

	method configurarTeclasGenerales(){
		keyboard.p().onPressDo({musica.pausar()})
		keyboard.r().onPressDo({musica.reproducir()})
		keyboard.backspace().onPressDo{game.stop()}
	}
	
	method configurarTeclasGuardia(){
		keyboard.right().onPressDo({guardia.mirarDerecha()})
		keyboard.left().onPressDo({guardia.mirarIzquierda()})
		keyboard.space().onPressDo({guardia.dejarTrampa()})
		
		//* Teclas hack
		keyboard.s().onPressDo({juego.atraparTodosLosEnemigos()})
		keyboard.m().onPressDo{juego.volverAlMenu()}
	}
}


