import UIKit
import Combine

/*
 {
 "userId": 1,
 "id": 1,
 "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
 "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
 },
 */

enum ApiError:Error{
    case badResponse
}

struct User:Decodable{
    let id:Int
    let title:String
}

struct Fact:Decodable{
    let fact: String
    let length: Int
}
print("Bye")
var cancellable = Set<AnyCancellable>()
let queue = DispatchQueue.global()

func makeApiCall()->AnyPublisher<[User], Error>{
    let url = URL(string: "https://jsonplaceholder.typicode.com/posts")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: queue)
        .tryMap{ data, response in
            if let response = response as? HTTPURLResponse, 
                response.statusCode != 200{
                throw ApiError.badResponse
            }
            return data
        }
        .decode(type: [User].self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

func getUser()->AnyPublisher<Fact, Error>{
    let url = URL(string: "https://catfact.ninja/fact")!
    return URLSession.shared.dataTaskPublisher(for: url)
        .receive(on: queue)
        .tryMap{ data, response in
            if let response = response as? HTTPURLResponse,
                response.statusCode != 200{
                throw ApiError.badResponse
            }
            return data
        }
        .decode(type: Fact.self, decoder: JSONDecoder())
        .eraseToAnyPublisher()
}

let postPublisher = makeApiCall()
let userPublisher = getUser()
let latestPublisher = Publishers.CombineLatest(postPublisher, userPublisher)
let zipPublisher = Publishers.Zip(postPublisher, userPublisher)
//let mergePublisher = Publishers.Merge(postPublisher, userPublisher) //This will be used in sametime

zipPublisher.sink { completion in
    switch completion{
    case .finished:
        print("zip api is done")
    case .failure(let error):
        print("api call failed \(error)")
    }

} receiveValue: { post, user in
    print (post)
}.store(in: &cancellable)

