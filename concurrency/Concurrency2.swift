import Foundation
import Dispatch
import Glibc

func fib(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return fib(n-1) + fib(n-2)
}


let queue = DispatchQueue.global(qos: .userInitiated)
let group = DispatchGroup()
var arr: [Int] = []
for i in [45, 50, 55] {
    queue.async(group: group) {
      print("Empieza fibonacci de \(i)")
      for _ in 1..<5 {
        sleep(1)
   	    arr.append(i)
      }

      print(arr)
      print(fib(i))
    }
}
group.wait()
print("Terminó todo el grupo!")










/*

let queue = DispatchQueue.global(qos: .userInitiated)
let auxQueue = DispatchQueue(label: "my.queue.for.writting", attributes: .concurrent)
let group = DispatchGroup()
var arr: [Int] = []
for i in [35, 40, 45] {
    queue.async(group: group) {
      print("Empieza fibonacci de \(i)")

      auxQueue.async(flags: .barrier){
        print("Empieza appendeo de \(i)")
        for _ in 1..<4 {
	       sleep(1)
   	     arr.append(i)
        }

        print(arr)
	    }

      print(fib(i))
    }
}
group.wait()
print("Terminó todo el grupo!")

*/
