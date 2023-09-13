//
//  ViewModel.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/09/23.
//

import Foundation
import Combine

class FeedViewModel: ObservableObject{
    @Published var arrFeedData = [Result]()
    var subscriber = Set<AnyCancellable>()
    func getFeed(){
        let url = "https://rss.applemarketingtools.com/api/v2/us/apps/top-free/50/apps.json"
        let publisher:AnyPublisher<FeedData, Error> = HTTPClient.shared.getRecord(url: url)
        publisher.sink { value in
            switch value{
            case .finished:
                print("Received value")
            case .failure(let error):
                print(error)
            }
        } receiveValue: {[weak self] feedData in
            DispatchQueue.main.async {
                self?.arrFeedData = feedData.feed.results
            }
        }
        .store(in: &subscriber)
    }
}
