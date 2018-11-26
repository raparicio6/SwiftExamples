import Dispatch
import Glibc

func fib(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return fib(n-1) + fib(n-2)
}

func hacerVariosFibonacci(_ numbers: [Int]){
    //let fibonacciGroup = DispatchGroup()

    for number in numbers {

      // Se notifica al grupo que se ha iniciado una tarea
      //fibonacciGroup.enter()
      DispatchQueue.global(qos: .userInitiated).async {
        print("Empieza fibonacci de " + String(number))
        let result = fib(number)
        print("Fibonacci de " + String(number) + " es " + String(result))
      }
      //fibonacciGroup.leave()
    }

    // Se bloquea el hilo actual mientras se espera la finalización de las tareas
    //fibonacciGroup.wait()

    //print("Terminaron todos los fibonaccis")
}

func operacionesMatematicas(_ arr: [Int]){
  hacerVariosFibonacci(arr)

	usleep(100 * 1_000_000)
}

let arr = [50, 45, 19, 10, 9, 8, 7, 6]
operacionesMatematicas(arr)
