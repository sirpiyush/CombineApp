//
//  MovieView.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/11/23.
//

import SwiftUI

struct MovieView: View {
    @StateObject var viewModel = MovieViewModel()
    @State var searchText = ""
    var body: some View {
        VStack{
            TextField(text: $viewModel.textFieldText) {
                Text("User Name")
                    .foregroundColor(.gray)
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            List{
               
                ForEach(0..<viewModel.arrMovies.count, id:\.self){index in
                  MovieChildView(movie: viewModel.arrMovies[index])
              }
            }
            //Added search bar
            /*
            .searchable(text: $searchText)
            .onChange(of: searchText, perform: { value in
                viewModel.currentTextPublisher.send(value)
            })
            */
        }.onAppear{
            viewModel.publisherSetUp()
        }
    }
}

struct MovieChildView:View{
    let movie:Movie
    
    var body:some View{
        HStack(spacing:20){
            

            Text(movie.title)
        }
        .padding(10)
    }
}

#Preview {
    MovieView()
}
