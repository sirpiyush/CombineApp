import UIKit
import Combine

let passThroughSubject = PassthroughSubject<Int, Never>()
let passThroughCancellable = passThroughSubject
    .sink { value in
        print(value)
    }
passThroughSubject.send(10)
passThroughSubject.send(40)


let currentSubject = CurrentValueSubject<String, Never>("John")
let currentCancellable = currentSubject.sink { value in
    print(value)
}

currentSubject.send("Hello")
currentSubject.send("Brother")


class WeatherClient{
    var subject = PassthroughSubject<Int, Never>()
    func getTemperature(){
        DispatchQueue.main.asyncAfter(deadline: .now()+2){[weak self]in
            self?.subject.send(Int.random(in:100...200))
        }
    }
}

let weatherClient = WeatherClient()
weatherClient.getTemperature()
let cancellable = weatherClient.subject.sink { value in
    print(value)
}
