// Electric Cars
protocol Chargeable {
    func recharge()
}

// Gas Cars
protocol Fillable {
    func fillTank()
}

// Features Needed by both
protocol Driveable {
    func start()
    func stop()
    func park()
}

// Now each struct only uses the features it needs!
struct ElectricVehicle: Driveable, Chargeable{
    
}

struct SportsVehicle: Driveable, Fillable{
    
}

// extending for classes
extension Chargeable where Self:ElectricVehicle{
    func recharge(batteryLevel:Int){
        self.batteryLevel = 100
    }
}
