/*
 {
 "Title": "They Call Me Spiderman",
 "Year": "2016",
 "imdbID": "tt5861236",
 "Type": "movie",
 "Poster": "https://m.media-amazon.com/images/M/MV5BODZkM2I4ZGUtZDBhZS00ODEyLTljMzQtYWFjOGVjZWI1MTYxXkEyXkFqcGdeQXVyMjcyNTc3NzA@._V1_SX300.jpg"
 },
 */

import Foundation

struct MovieRespose:Decodable{
    let Search:[Movie]
}

struct Movie:Decodable{
    let title:String
    let poster:String
    let imdbID:String
    
    enum CodingKeys: String,CodingKey{
        case title = "Title"
        case poster = "Poster"
        case imdbID
    }
}
