

//Enumeración velocidades

enum Velocidades : Int {

    case Apagado = 0
    case VelocidadBaja = 20
    case VelocidadMedia = 50
    case VelocidadAlta = 120
    
    init(velocidadInicial : Velocidades){
        self = velocidadInicial
    }
}


//Clase Auto

class Auto{

    var velocidad : Velocidades;
    
    init(){
        velocidad = Velocidades(velocidadInicial: .Apagado)
    }
 
    func cambioDeVelocidad() -> (actual : Int, velocidadEnCadena : String){
        let velocidadActual : Int = velocidad.rawValue
        
        switch velocidad{
        
        case .Apagado:
            velocidad = Velocidades.VelocidadBaja
            return (velocidadActual, "Apagado")
        case .VelocidadBaja:
            velocidad = Velocidades.VelocidadMedia
            return (velocidadActual, "Velocidad Baja")
        case .VelocidadMedia:
            velocidad = Velocidades.VelocidadAlta
            return (velocidadActual, "Velocidad Media")
        case .VelocidadAlta:
            velocidad = Velocidades.VelocidadMedia
            return (velocidadActual, "Velocidad Alta")
        
        }
    }
}

let auto = Auto()

for i in 0..<20 {
    let resultadoCambioVelocidad  = auto.cambioDeVelocidad();
    print("\(i+1). \(resultadoCambioVelocidad.actual), \(resultadoCambioVelocidad.velocidadEnCadena) ")
}