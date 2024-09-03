//
//  CompactMap.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 02/09/24.
//

import Foundation
import SwiftUI

struct CompactMapView:View {
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
        let dict = [1:"One", 2:"Two", 3:"Three", 5:"Five"]
        let range = 1...5
        var cancellable =
        range.publisher
            .map{dict[$0]}
            .sink {[weak self] value in
                self?.arr.append(value ?? "Hello")
            }
        
    }
    
}


#Preview {
    CompactMapView()
}
