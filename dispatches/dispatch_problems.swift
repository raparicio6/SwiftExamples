protocol Movable {
    //Dynamic dispatch
    func walk() -> String
}

extension Movable{
    //Static dispatch
    func crawl() -> String {
        return "Default crawling"
    }
}

struct Animal:Movable{
    func walk() -> String {
        return "Custom Animal walking"
    }

    func crawl() -> String {
        return "Custon Animal crawling"
    }
}

let wolf:Animal = Animal()
print(wolf.walk())
print(wolf.crawl())

let wolf2:Movable = Animal()
print(wolf2.walk())
print(wolf2.crawl()) //Se buscó en tiempo de compliación

