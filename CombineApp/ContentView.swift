//
//  ContentView.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/09/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PopulationViewModel()
    var body: some View {
        NavigationView {
            List{
                ForEach (0..<viewModel.arrData.count, id:\.self){index in
                    NavigationLink {
                        FeedView()
                    } label: {
                        VStack {
                            Text(viewModel.arrData[index].Nation)
                                .foregroundColor(.red)
                            Text("\(viewModel.arrData[index].Population)")
                        }
                    }
                }
            }
            .navigationTitle("Population")
        }.onAppear{
            viewModel.getPopulation()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
