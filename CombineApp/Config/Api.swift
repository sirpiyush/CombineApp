//
//  Api.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 03/11/23.
//

import Foundation

enum Api:String{
    case url = "https://www.omdbapi.com/?"
    case key = "apikey=5fd3d23"
    
    static func apiUrl(searchText:String)->String{
        Api.url.rawValue+Api.key.rawValue+searchText
    }
}
