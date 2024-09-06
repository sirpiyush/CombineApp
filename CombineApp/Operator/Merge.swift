//
//  Merge.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 05/09/24.
//

import SwiftUI

struct Merge: View {
    @StateObject var viewModel=MergeViewModel()
    var body: some View {
        List(viewModel.arrPublished, id: \.self){value in
            Text("\(value)")
        }.onAppear{
            viewModel.loadData()
        }
    }
    
    class MergeViewModel:ObservableObject{
        @Published var arrPublished = [Int]()
        func loadData(){
            let publisher1 = (1...5).publisher
            let publisher2 = (10...15).publisher
            let publisher3 = (16...20).publisher
            let publisher4 = (21...25).publisher
            let cancellable = publisher1
                .merge(with:publisher2, publisher3, publisher4)
                .sink {[weak self] value in
                    self?.arrPublished.append(value)
                }
        }
    }
    
}

#Preview {
    Merge()
}
