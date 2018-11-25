/*class foo {

    func bar(){
        print ("Not implemented here")
        fatalError()
    }

}

class baz: foo{
}

var x = baz()
x.bar() //No compiler help..

*/


protocol foo {
    var x:String {get set}
}

struct bar:foo {
}

//Compilador al rescate!