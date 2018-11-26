import Foundation
import Dispatch
import Glibc

func fib(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return fib(n-1) + fib(n-2)
}

func hacerVariosFibonacci(_ n: [Int]) {
  let queue = DispatchQueue.global(qos: .userInitiated)
  let auxQueue = DispatchQueue(label: "my.queue.for.writting", attributes: .concurrent)
  let group = DispatchGroup()
  var arr: [Int] = []
  for i in n {
      queue.async(group: group) {

        auxQueue.async(){
          print("Empieza appendeo de \(i)")
          for _ in 1..<4 {
            sleep(1)
   	        arr.append(i)
          }

          print(arr)
        }

        print("Empieza fibonacci de \(i)")
        print("Fibonacci de \(i): " + String(fib(i)))
      }
  }

  group.wait()
  print("Terminó todo el grupo!")
}


let arr = [45,50,55]
hacerVariosFibonacci(arr)


/*





// flags: .barrier
