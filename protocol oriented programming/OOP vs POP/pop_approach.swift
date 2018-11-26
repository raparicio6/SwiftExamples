import XCTest

// Gas Cars
protocol Fillable {
    var filledQuantity: Int { get set } 
    mutating func fillTank(quantity: Int)
}

extension Fillable {
	mutating func fillTank(quantity: Int){
		self.filledQuantity += quantity
	}
}

// Features Needed by both
protocol Driveable {
    var wheels: Int { get }
    var isMoving: Bool { get set }
    var topSpeed: Int { get }
    mutating func start()
    mutating func stop()
}

extension Driveable {

	mutating func start(){
		self.isMoving = true
	}

	mutating func stop(){
		self.isMoving = false
	}

}

struct GasCar: Fillable, Driveable {
	var filledQuantity: Int 
	var wheels: Int 
    var isMoving: Bool 
    var topSpeed: Int 
}


struct SuperVehicle: Fillable, Driveable {

	var filledQuantity: Int 
	var wheels: Int 
    var isMoving: Bool 
    var topSpeed: Int 
    var turbo: Bool

    mutating func start(){
    	self.isMoving = true
    	self.turbo = true
    }
}


//We now requiere electric cars

// Electric Cars
protocol Chargeable {
    var batteryLevel: Int { get set } 
    mutating func recharge(quantity: Int)
}

// extending for classes
extension Chargeable{
    mutating func recharge(quantity: Int){
        self.batteryLevel += quantity
    }
}


// Now each struct only uses the features it needs!
struct ElectricVehicle: Driveable, Chargeable{
    var wheels: Int 
    var isMoving: Bool 
    var topSpeed: Int 
    var batteryLevel: Int
}

/*Unrelated objects*/

struct Bucket: Fillable {
	var filledQuantity: Int
}


final class AppTests : XCTestCase {


    func testGasCarRunningAfterStart(){
    	var gasCar = GasCar(filledQuantity: 100, wheels:4,
    						 isMoving:false, topSpeed: 120)
    	gasCar.start()
    	XCTAssert(gasCar.isMoving)
    }

    func testSuperVehicleIsOnTurboAfterStart(){
    	var superVehicle = SuperVehicle(filledQuantity: 100, wheels:4,
    									 isMoving:false, topSpeed: 120, turbo:false)
    	superVehicle.start()
    	XCTAssert(superVehicle.turbo)
    }

    func testElectricVehicleChargedAfterCharging(){
    	var electricVehicle = ElectricVehicle(wheels: 4, isMoving: false,
    						 topSpeed: 120, batteryLevel: 50)
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