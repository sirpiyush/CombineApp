//
//  ViewModel.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/09/23.
//

import Foundation
import Combine

class PopulationViewModel: ObservableObject{
    @Published var arrData = [Data]()
    var subscriber = Set<AnyCancellable>()
    /*func getPopulation1(){
        HTTPClient.shared.getRecord()
            .map(\.data)
            .receive(on: DispatchQueue.main)
            .sink {completion in
                switch completion{
                case .finished:()
                case .failure(let error):
                    print(error)
                    
                }
            } receiveValue: {[weak self] arrayUSData in
                self?.arrData = arrayUSData
            }
            .store(in: &cancellable)
    }
    */
    
    func getPopulation(){
        let url = "https://datausa.io/api/data?drilldowns=Nation&measures=Population"
        let publisher:AnyPublisher<USData, Error> = HTTPClient.shared.getRecord(url: url)
        publisher.sink { value in
            switch value{
            case .finished:
                print("Received value")
            case .failure(let error):
                print(error)
            }
        } receiveValue: {[weak self] usdata in
            DispatchQueue.main.async {
                self?.arrData = usdata.data
            }
        }
        .store(in: &subscriber)
    }
}
