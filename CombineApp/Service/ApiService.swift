//
//  HTTPClient.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/11/23.
//

import Foundation
import Combine


class ApiService{
    
    func getMovie(urlString:String)->AnyPublisher<[Movie], Error>{
        guard let url = URL(string: urlString)
        else {
            /*return Fail<[Movie], Error>(error: ApiError.invalidUrl)
                .eraseToAnyPublisher()
             */
            return Fail(error: ApiError.invalidUrl)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: MovieRespose.self, decoder: JSONDecoder())
            .map(\.Search)
            .catch{ error in
                //This way we can throw error with exact issue
                return Fail(error: ApiError.otherError(msg: "\(error)"))
                    .eraseToAnyPublisher()
                
                //This way we are sending value in case occur comes.
//                Just([]).setFailureType(to: Error.self)
//                    .eraseToAnyPublisher()

            }
            .eraseToAnyPublisher()
    }
    
}
