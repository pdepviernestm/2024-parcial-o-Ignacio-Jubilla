
class Persona{
    var property edad

    const emociones=[]

    method esAdolescente() = edad>=12 and edad<=19

    method agregarEmocion(nuevaEmocion){emociones.add(nuevaEmocion)}
    
    method porExplotar() = emociones.all({emocion=>emocion.puedeLiberarse()})
    
    method vivirEvento(cual){cual.consecuencia()}

}

object intensidad {
    var property valorIntensidadElevada=0
}

class Grupo{
    var property integrantes=[]

    method vivirEvento(cual){integrantes.forEach({persona=>persona.vivirEvento(cual)})}

}


class Evento{

    var property impactoEvento

    var property descripcion="" // char[n]

    method consecuencia(){
        Persona.emociones.forEach({emocion=>emocion.liberarse()})
    }
}

class Emocion{
    var property intensidad

    var property eventosExperimentados=[]

    var property cantEventosExperimentados=self.eventosExperimentados().size()

    method disminuirIntensidad(cuanto){intensidad=-cuanto}

    method puedeLiberarse(){return }

    method consecuencia(){}

    //method liberarse(){} // si cumple es liberable

    method liberarse(){
        if(self.puedeLiberarse()){

            self.consecuencia()

        }
    }
    
    method intensidadElevada() = self.intensidad()>intensidad.valorIntensidadElevada()

}

class Furia inherits Emocion(intensidad=100){
    const property palabrotas=[]
    method aprenderPalabrota(p){palabrotas.add(p)}
    method olvidarPalabrota(p){palabrotas.remove(p)}

    override method puedeLiberarse()=self.palabraConMasDeSiete(palabrotas) and self.intensidadElevada()

    override method consecuencia(){
        self.disminuirIntensidad(Evento.impactoEvento())
        palabrotas.remove(palabrotas.head())} //la primera
    

    method palabraConMasDeSiete(lista)=lista.any({p=>p.size()>7})
    
}


class Alegria inherits Emocion(intensidad=0){

    override method puedeLiberarse()=self.intensidadElevada() and self.cantEventosExperimentados().even()

    override method consecuencia(){
        self.disminuirIntensidad(Evento.impactoEvento())
    }


    override method disminuirIntensidad(cuanto){
        intensidad=-cuanto
        intensidad.abs()
    }

    
    method intensidadPositiva(a) = a.abs()

}

class Tristeza inherits Emocion(intensidad=0){

    var property causa="melancolia"

    override method puedeLiberarse()=self.causa()!="melancolia" and self.intensidadElevada()

    override method consecuencia(){
        self.causa(Evento.descripcion())
        self.disminuirIntensidad(Evento.impactoEvento())
    }

}

class DesTem inherits Emocion(intensidad=0){

    override method puedeLiberarse()=self.intensidadElevada() and self.masEvQueIntens()

    override method consecuencia(){self.disminuirIntensidad(Evento.impactoEvento())}

    method masEvQueIntens()= self.cantEventosExperimentados()>self.intensidad()
}

class Desagrado inherits DesTem{}
class Temor inherits DesTem{}


// ANSIEDAD

class Ansiedad inherits Emocion(intensidad=4){
    
    override method puedeLiberarse()=self.intensidadNegativa()

    override method consecuencia(){
        self.disminuirIntensidad(Evento.impactoEvento())
    }

    method intensidadNegativa()=self.intensidad()<0

}


/*
 ---PARTE-TEORICA---
Polimorfismo y herencia, cliche de la programacion.
Primero, en cuanto a la herencia, este concepto fue fundamental 
en el desarrollo de este parcial, ya que permitio generalizar el modelado 
de las emociones por ejemplo, lo cual, sin el uso de dicho concepto, seria impractico,
asi que se utiliza la instanciacion de clases padre.
El polimorfismo a su vez, sirvio por ejemplo a la hora de escribir el metodo vivirEvento(), 
ya que dependera lo que haga de lo que se le pase, si una persona o un grupo. 
Por lo tanto se puede afirmar que permite que la respuesta varie dependiendo a lo que se le consulta.

*/

