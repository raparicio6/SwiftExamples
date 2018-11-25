class Vehicle {
    var wheels: Int
    var isMoving: Bool
    var topSpeed: Int
    var gasTank: Int
    
    
    init(wheels:Int = 4, isMoving:Bool = false, topSpeed:Int = 100, gasTank:Int = 100){
        self.wheels = wheels
        self.isMoving = isMoving
        self.topSpeed = topSpeed
        self.gasTank = gasTank
    }
    
    func start(){}
    func stop(){}
    func park(){}
    func fillGas(){}
}


// Sports Vehicle class inherits from vehicle
class SportsVehicle: Vehicle {
    
    var isTurbo: Bool
    
    func goTurbo(){}
    
    init(){
        self.isTurbo = false
        super.init()
        
    }
}

class ElectricVehicle: Vehicle {
    
    var batteryLevel: Int
    func rechargeBattery(){}
    
    init(){
        self.batteryLevel = 5
        super.init()
    }
}
