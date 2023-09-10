//
//  Population.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 10/09/23.
//

import Foundation

struct USData:Decodable{
    let data:[Data]
}

struct Data:Decodable{
    let Nation:String
    let Population:Int
}
