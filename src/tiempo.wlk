import wollok.game.*

class Tiempo {
	
	var tiempoTotal = 0 //ms
	var frecuencia // hs
	var property contador = 0
	const resultadoPartida
	
	method miTiempoTotal(unTiempo){tiempoTotal = unTiempo}
	
	method espaciamiento()=1000/frecuencia //ms
	
	method tiempoRestante() = tiempoTotal - self.espaciamiento()*contador //ms

	method detener() = game.removeTickEvent(self.identity().toString())
	
	method onTick(unSonido){
		
		if(self.tiempoRestante()<=0){
			self.detener()
			resultadoPartida.mostrarResultado(unSonido)
		} 
		
		contador+=1
	}
	
	method mostrarNumero() = (self.tiempoRestante()/1000).truncate(0)
	
	method empezar(unSonido) = game.onTick(1000/frecuencia, self.identity().toString(), {self.onTick(unSonido)})
	
}

class Digito{
	
	var posicionDigito
	var numero
	var posicionBase
	
	method position() = posicionBase.right(posicionDigito)
	
	method digitoCorrespondiente(){
		
		const numeroAString = numero.mostrarNumero().toString()
		
		return if (numeroAString.size() - 1 < posicionDigito)
			"sinNumero"
		else
			numeroAString.charAt(posicionDigito)
	}
	
	method image() = "numeros/"+self.digitoCorrespondiente()+".png"
	
	method colisiona(alguien){}
}

class GenerarNumerosVisibles{
	
	method generarDigitos(tiempoMaximoPartida, unTiempo, posicion){
		const cantidadDeDigitosParaElReloj = tiempoMaximoPartida.toString().size()
		cantidadDeDigitosParaElReloj.times({i => game.addVisual(new Digito(posicionDigito = i-1, numero = unTiempo, posicionBase = posicion))})
	}
}
