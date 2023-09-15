//
//  HTTPClient.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/09/23.
//

import Foundation
import Combine



enum ApiError:Error{
    case networkError
    case invalidUrl
    case badResponse
    case otherError(msg:String)
}

final class HTTPClient{
    static let shared = HTTPClient()
    let decoder = JSONDecoder()
    var cancellable = Set<AnyCancellable>()
    private init(){}
    
    func getRecord<T:Decodable>(url:String)->AnyPublisher<T, Error>{
        guard let url = URL(string: url)
        else{return Fail(error:ApiError.invalidUrl).eraseToAnyPublisher()}
        return URLSession
            .shared
            .dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .tryMap { (data, response)->JSONDecoder.Input in
                        guard let httpResponse = response as? HTTPURLResponse,
                                  (200...299).contains(httpResponse.statusCode)
                        else {throw ApiError.badResponse}
                        return data
                    }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getData<T:Decodable>(urlString:String, responseType:T.Type)->Future<T, Error>{
        return Future(){ [self]promise in
            guard let url = URL(string: urlString)
            else{promise(.failure(ApiError.invalidUrl)); return}
            URLSession
                .shared
                .dataTaskPublisher(for: url)
                .tryMap({ data, response in
                    guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode)
                    else {throw(ApiError.badResponse)}
                    return data
                })
                .decode(type: responseType, decoder: JSONDecoder())
                .sink { completion in
                    switch (completion){
                    case .finished:
                        print("Do nothing")
                    case .failure(let error):
                        let errorInfo = "\(error)"
                        promise(.failure(ApiError.otherError(msg:errorInfo)))
                    }
                }
                receiveValue: { value in
                    promise(.success(value))
                }.store(in: &cancellable)

        }
        
        
    }
}
