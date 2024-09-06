//
//  CompactMap.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 02/09/24.
//

import Foundation
import SwiftUI

struct CompactMapView:View {
    //Added state object
    @StateObject var viewModel = CompactMapViewModel()
    var body: some View {
        List(viewModel.arr, id: \.self){ data in
            Text(data)
        }.onAppear{
            viewModel.loadData()
        }
    }
}

class CompactMapViewModel:ObservableObject{
    
    @Published var arr : [String] = []
    
    func loadData(){
        let dict = [1:"One", 2:"Two", 3:"Three", 5:"Five", 8:"Eight", 10:"Ten", 11:"Eleven"]
        let range = 1...15
        let cancellable =
        range.publisher
            .compactMap{ (value)->String? in
                dict[value]
            }
            .sink {[weak self] value in
                self?.arr.append(value ?? "Hello")
            }
        cancellable.cancel()
        
    }
    
}


#Preview {
    CompactMapView()
}
