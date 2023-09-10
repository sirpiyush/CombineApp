//
//  Feed.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 10/09/23.
//

import Foundation
struct FeedData:Decodable{
    let feed:Feed
}

struct Feed:Decodable{
    let results:[Result]
}
struct Result:Decodable{
    let artistName:String
    let name:String
    let id:String
    let artworkUrl100:String
}
