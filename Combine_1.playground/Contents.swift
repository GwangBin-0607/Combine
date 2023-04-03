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
        DispatchQueue.global(qos: .background).asyncAfter(deadline: .now() + 3.0, execute: {
                subscriber.receive([
                    Product(name: "TEST 1", price: 1000),
                    Product(name: "TEST 2", price: 200)
                ])
                subscriber.receive(completion: .finished)
        })
    }
}
let request = ProductList()
request.sink(receiveCompletion: {
    _ in
    print("Completion")
}, receiveValue: {
    list in
    print(list)
})
