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
    case invalidResponse
}

final class HTTPClient{
    static let shared = HTTPClient()
    let decoder = JSONDecoder()
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
                        else {throw ApiError.invalidResponse}
                        return data
                    }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
    
    func getData<T:Decodable>(urlString:String)->Future<T, Error>{
        guard let url = URL(string: urlString)
        else{
            return Future(){promise in
                promise(Result.failure(ApiError.invalidUrl))
            }
        }
        
        return Future(){promise in
            let data = URLSession
                .shared
                .dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: T.self, decoder: JSONDecoder())
            promise(Result.success(data))
        }
        
        
    }
}
