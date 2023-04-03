import Combine
import Foundation
struct Product:Decodable{
    let name:String
    let price:Int
}
enum HTTPError:Error{
    case DecodeError
    case RequestError
}
class ProductList:Publisher{
    typealias Output = [Product]
    typealias Failure = HTTPError
    
    func receive<S>(subscriber: S) where S : Subscriber, HTTPError == S.Failure, [Product] == S.Input {
        debugPrint("Receive")
        let a = aa()
        subscriber.receive(subscription: a)
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3.0, execute: {
                subscriber.receive([
                    Product(name: "TEST 1", price: 1000),
                    Product(name: "TEST 2", price: 200)
                ])
                subscriber.receive(completion: .finished)
        })
    }
}
class aa:Subscription{
    func request(_ demand: Subscribers.Demand) {
        
    }
    
    func cancel() {
        
    }
    
    
}
class Cus:Subscriber{
    typealias Input = [Product]
    typealias Failure = HTTPError
    func receive(_ input: [Product]) -> Subscribers.Demand {
        debugPrint("LIST")
        debugPrint(input)
        return Subscribers.Demand.none
    }
    func receive(completion: Subscribers.Completion<HTTPError>) {
        debugPrint("Completion !!")
    }
    func receive(subscription: Subscription) {
        debugPrint("SubScriprt")
        debugPrint(subscription)
    }
}
func a(){
    let request = ProductList()
    let sub = Cus()
    request.subscribe(sub)
}
a()
//request.sink(receiveCompletion: {
//    _ in
//    print("Completion")
//}, receiveValue: {
//    list in
//    print(list)
//})
