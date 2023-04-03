import Combine

let future:Future<Int,Error> = Future{
    promise in
    promise(.success(100))
}
class S:Subscriber{
    typealias Input = Int
    
    typealias Failure = Error
    
    func receive(subscription: Subscription) {
        subscription.request(Subscribers.Demand.max(1))
    }
    func receive(_ input: Int) -> Subscribers.Demand {
        debugPrint(input)
        return Subscribers.Demand.none
    }
    func receive(completion: Subscribers.Completion<Failure>) {
        debugPrint("Completion~~~!")
    }
    
    
}
let s = S()
future.subscribe(s)
future.subscribe(s)
future.sink(receiveCompletion: {
    _ in
    print("Completion")
}, receiveValue: {
    print($0)
})
future.sink(receiveCompletion: {
    _ in
    print("Completion")
}, receiveValue: {
    print($0)
})
