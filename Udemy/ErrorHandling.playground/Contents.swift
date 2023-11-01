import UIKit
import Combine

enum CustomError:Error{
    case failed
}
var cancellable = Set<AnyCancellable>()

let arrayPublisher = [1, 2, 3, 4].publisher

//quitAfterErrorComes()
continueAfterErrorComes()

func continueAfterErrorComes()
{
    let doublePublisher = arrayPublisher.tryMap { value in
        if value == 4{
            throw CustomError.failed
        }
        return value*2
    }.catch{error in
        return Just(2)
    }
    
    let subscriber = doublePublisher.sink { completion in
        switch completion{
        case .finished:
            print("finished")
        case .failure(let failure):
            print(failure)
        }
    } receiveValue: { value in
       print (value)
    }

    subscriber.store(in: &cancellable)
}

func quitAfterErrorComes()
{
    let doublePublisher = arrayPublisher.tryMap { value in
        if value == 4{
            throw CustomError.failed
        }
        return value*2
    }.mapError{error in
        return CustomError.failed
    }
    let subscriber = doublePublisher.sink { completion in
        switch completion{
        case .finished:
            print("finished")
        case .failure(let failure):
            print(failure)
        }
    } receiveValue: { value in
       print (value)
    }

    subscriber.store(in: &cancellable)
}
