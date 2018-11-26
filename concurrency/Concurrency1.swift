import Dispatch
import Glibc

func operacionesBasicas(_ n: Int){
	print("Multiplico por 2: " + String(n * 2))
	print("Divido por 2: " + String(Double(n) / 2))
	print("Elevo al cuadrado: " + String(n * n))
	print("Raiz cuadrada: " + String(Double(n).squareRoot()))

	print("Resto de operaciones..")
}

func fib(_ n: Int) -> Int {
    guard n > 1 else { return n }
    return fib(n-1) + fib(n-2)
}

func hacerFibonacci(_ n: Int){
  DispatchQueue.global(qos: .background).async {
    print("Empiezo a calcular Fibonacci")
    print("Fibonacci: " + String(fib(n)))
  }
}

func operacionesMatematicas(_ n: Int){
  hacerFibonacci(n)

	operacionesBasicas(n)

	usleep(100 * 1_000_000)
}

operacionesMatematicas(45)





/*

DispatchQueue.main
DispatchQueue.global(qos: .userInitiated)
DispatchQueue(label: "my.concurrent.queue", attributes: .concurrent)

*/
