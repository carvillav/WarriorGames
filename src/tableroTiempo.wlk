import wollok.game.*

class Tiempo {
	
	var tiempoTotal //ms
	var frecuencia // hs
	var property contador = 0
	
	method espaciamiento()=1000/frecuencia //ms
	
	method tiempoRestante() = tiempoTotal - self.espaciamiento()*contador //ms

	method detener() = game.removeTickEvent(self.identity().toString())
	
	method onTick(){
		if(self.tiempoRestante()<=0) self.detener()
		contador+=1
	}
	
	method mostrarNumero() = (self.tiempoRestante()/1000).truncate(0)
	
	method empezar() = game.onTick(1000/frecuencia, self.identity().toString(), {self.onTick()})

}

class Digito {
	
	var posicionDigito
	var numero
	var posicionBase
	
	method position() = posicionBase.right(posicionDigito)
	
	method digitoCorrespondiente(){
		
		const numberAsString = numero.mostrarNumero().toString()
		
		return if (numberAsString.size() - 1 < posicionDigito)
			"sinNumero"
		else
			numberAsString.charAt(posicionDigito)
	}
	
	method image() = "numeros/"+self.digitoCorrespondiente()+".png"
	
	method colisiona(alguien){}
}

object generarNumerosVisibles{
	method generarDigitos(maximumNumber,numero,position){
		const cantidadDeDigitosParaElReloj = maximumNumber.toString().size()
		cantidadDeDigitosParaElReloj.times({i => game.addVisual(new Digito(posicionDigito = i-1, numero = numero, posicionBase = position))})
	}
}