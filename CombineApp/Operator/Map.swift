//
//  Map.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/09/24.
//

import SwiftUI
import Combine

struct Map: View {
    struct IPData: Decodable{
        let ip:String
        let network:String
        let version:String
    }
    
    
    @StateObject var mapViewModel = MapViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .onAppear{
                mapViewModel.loadData()
            }
    }
    
    class MapViewModel:ObservableObject{
        @Published var arr : [String] = []
        var cancellable : Set<AnyCancellable> = []
        func loadData(){
            let request = URLRequest(url: URL(string: "https://ipapi.co/jsonsd/")!)
            URLSession.shared.dataTaskPublisher(for: request)
                .map { (data, response) in
                    data
                }
                .decode(type: IPData.self, decoder: JSONDecoder())
                .sink { completion in
                    switch (completion){
                    case .finished:
                        print("finished")
                    case .failure(let error):
                        print("we found error to \(error)")
                        
                    }
                } receiveValue: { data in
                    print(data)
                }.store(in: &cancellable)
            
        }
    }
}



#Preview {
    Map()
}
