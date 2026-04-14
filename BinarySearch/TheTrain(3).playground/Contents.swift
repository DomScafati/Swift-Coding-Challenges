import UIKit

// You're a conductor on a train. Each car holds a number of passengers and a reference to the next car. Return the total number of passengers on the entire train.

class Car {
    var passengers: Int
    var next: Car?
    init(_ passengers: Int, next: Car? = nil) {
        self.passengers = passengers
        self.next = next
    }
}

func totalPassengers(_ head: Car?) -> Int {
    var count = 0
    var current = head
    while current != nil {
        count += current?.passengers ?? 0
        current = current?.next
    }
    return count
}

let car1 = Car(12)
let car2 = Car(8)
let car3 = Car(15)
let car4 = Car(6)
car1.next = car2
car2.next = car3
car3.next = car4
totalPassengers(car1)
// expected output: 41
