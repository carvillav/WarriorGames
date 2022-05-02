import wollok.game.*
import inicializaciones.*

class Pantalla {
	const property alto
	const property ancho
	const property image
	const property position
	const property titulo
	const property escenarioPrincipal
	const sonidoIntro = sonido.sonido("musica/intro")
	
	method mostrarPantallaInicial(){
		
		self.configurarPantalla()
		self. mostrar(pantallaInicial)
		
		//reproduce automáticamente el sonido
        game.schedule(1, {=> sonidoIntro.play()})

        //entra en un loop el sonido después de haber terminado
        sonidoIntro.shouldLoop(true)
		
		//Cerrar el juego
		self.cerrarPantalla()
		
		keyboard.enter().onPressDo{self.mostrarOpciones()}
	}
	
	method configurarPantalla(){
		game.height(alto)
		game.width(ancho)
		game.title(titulo)
		game.boardGround(image)//"suelo.gif"
	}
	
	method mostrar(algo) {game.addVisual(algo)}
	
	method cerrarPantalla() {keyboard.s().onPressDo{game.stop()}}
	
	method mostrarOpciones(){
		
		game.clear()
		self.mostrar(pantallaModoDeJuego)
		self.cerrarPantalla()
		keyboard.num1().onPressDo{self.iniciarJuego()}
	}
	
	method iniciarJuego(){
		game.clear()
		if(escenarioPrincipal === escenario) sonidoIntro.stop()
		
		escenarioPrincipal.iniciar()
	}
	
	method dentroDeLaPantalla(posicion){
		var nuevaPosicion = posicion
		//nuevaPosicion.x(posicion.x().min(ancho-1).max(0))
		//nuevaPosicion.y(posicion.y().min(alto-1).max(0))
		if(posicion.x() >= ancho) nuevaPosicion = game.at(ancho-1, nuevaPosicion.y())
		if(posicion.x() < 0) nuevaPosicion = game.at(0, nuevaPosicion.y())
		if(posicion.y() >= alto) nuevaPosicion = game.at(nuevaPosicion.x(), alto-1)
		if(posicion.y() < 0) nuevaPosicion = game.at(nuevaPosicion.x(), 0)
		return nuevaPosicion
	}
}


//
class Fondo {
	
	var property image 
	var property position = game.origin()

}

//SONIDO
object sonido {

    method sonido(audio) = game.sound(audio + ".mp3")

    method reproducir(audio) = self.sonido(audio).play()
    
    method parar(audio) = self.sonido(audio).stop()

}
