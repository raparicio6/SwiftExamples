import XCTest

class Vehicle {
    var wheels: Int
    var isMoving: Bool
    var topSpeed: Int
    var filledQuantity: Int
    
    
    init(wheels:Int = 4, isMoving:Bool = false, topSpeed:Int = 100, filledQuantity:Int = 100){
        self.wheels = wheels
        self.isMoving = isMoving
        self.topSpeed = topSpeed
        self.filledQuantity = filledQuantity
    }
    
    func start(){
    	self.isMoving = true
    }
    func stop(){
    	self.isMoving = false
    }
    func fillGas(quantity:Int){
    	self.filledQuantity += quantity
    }
}


// Sports Vehicle class inherits from vehicle
class SuperVehicle: Vehicle {
    
    var turbo: Bool
    
    func goTurbo(){
    	//Implementation here
    }
    func disableTurbo(){
    	//Implementation here
    }

    init(){
        self.turbo = false
        super.init()
        
    }

    override func start(){
    	self.turbo = true
    	self.isMoving = true
    }
}

class ElectricVehicle: Vehicle {
    
    var batteryLevel: Int
    func recharge(quantity: Int){
    	self.batteryLevel += quantity
    }
    
    init(){
        self.batteryLevel = 5
        super.init()
    }
}

final class AppTests : XCTestCase {


    func testGasCarRunningAfterStart(){
    	let gasCar = Vehicle(wheels:4, isMoving:false,
    						 topSpeed: 120, filledQuantity: 100)
    	gasCar.start()
    	XCTAssert(gasCar.isMoving)
    }

    func testSuperVehicleIsOnTurboAfterStart(){
    	let superVehicle = SuperVehicle()
    	superVehicle.start()
    	XCTAssert(superVehicle.turbo)
    }

    func testElectricVehicleChargedAfterCharging(){
    	let electricVehicle = ElectricVehicle()
    	let batteryBeforeCharge = electricVehicle.batteryLevel
    	electricVehicle.recharge(quantity: 50)
    	let batteryAfterCharge = electricVehicle.batteryLevel
    	XCTAssert(batteryAfterCharge > batteryBeforeCharge)
    }

    static let allTests = [
        ("testGasCarRunningAfterStart", testGasCarRunningAfterStart),
        ("testSuperVehicleIsOnTurboAfterStart", testSuperVehicleIsOnTurboAfterStart),
        ("testElectricVehicleChargedAfterCharging", testElectricVehicleChargedAfterCharging)
    ]
}

XCTMain([
    testCase(AppTests.allTests),
])