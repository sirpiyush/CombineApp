//
//  FeedView.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 10/09/23.
//

import SwiftUI

struct FeedView: View {
    @StateObject var feedViewModel = FeedViewModel()
    let columns = [GridItem(.flexible())]

    var body: some View {
        ZStack{
            ScrollView {
                LazyVGrid(columns: columns, spacing:20) {
                    ForEach(feedViewModel.arrFeedData, id: \.id){feed in
                        HStack(alignment:.top,spacing:0){
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(20)
                                .frame(width: 140)
                                .overlay {
                                    AsyncImage(url: URL(string: feed.artworkUrl100))
                                        .padding(20)
                                        //.frame(width: 120, height: 120)
                                }
                            

                            VStack (alignment: .leading, spacing: 0){
                                HStack(alignment: .top){
                                    Text(feed.name)
                                        .frame(maxWidth:.infinity, alignment:.leading)
                                    
                                    Circle()
                                        .fill(Color.black)
                                        .frame(width: 30, height: 30)
                                }
                                .background(Color.blue)
                                Text(feed.artistName)
                                    .padding(.top, 10)
                                
                                Spacer()
                                
                                VStack(spacing:0){
                                    Text("out of stock")
                                        .foregroundColor(.red)
                                        .frame(maxWidth:.infinity, alignment:.leading)
                                    
                                    HStack{
                                        Spacer()
                                        Capsule()
                                            .frame(width:100, height:30)
                                    }
                                }
                            }
                            .frame(width:189)
                            .background(Color.cyan)
                            .padding(12)
                               
                            
                            
                        }
                        //.padding(20)
                        .frame(width:350, height:140)
                        .background(
                        Rectangle()
                            .fill(Color.gray)
                            .border(Color.green, width: 1)
                            .cornerRadius(20)
                        
                        )
                        //.frame(width:300)
                    }
                }
                /*
                VStack(alignment: .leading, spacing: 10){
                    ForEach(feedViewModel.arrFeedData, id: \.id){feed in
                        
                        HStack(alignment:.top,spacing:0){
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(20)
                                .frame(width: 140)
                                .overlay {
                                    AsyncImage(url: URL(string: feed.artworkUrl100))
                                        .padding(20)
                                        //.frame(width: 120, height: 120)
                                }
                            

                            VStack (alignment: .leading, spacing: 10){
                                Text(feed.name)
                                    .frame(maxWidth:.infinity, alignment:.leading)
                                Text(feed.artistName)
                            }
                            .frame(width:189)
                            .background(Color.cyan)
                            .padding(12)
                               
                            
                            
                        }
                        //.padding(20)
                        .frame(width:350, height:140)
                        .background(
                        Rectangle()
                            .fill(Color.gray)
                            .border(Color.green, width: 1)
                            .cornerRadius(20)
                        
                        )
                        //.frame(width:300)
                    }
                }*/
                .background(Color(.systemGroupedBackground))
            }
            .onAppear{
                feedViewModel.getFeedData()
            }
            .navigationTitle("Feed")
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
    }
}
