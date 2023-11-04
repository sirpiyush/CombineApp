//
//  MovieViewModel.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 04/11/23.
//

import Foundation
import Combine
class MovieViewModel:ObservableObject{
    var cancellable = Set<AnyCancellable>()
    @Published var arrMovies = [Movie]()
    let apiService = ApiService()
    let currentTextPublisher = CurrentValueSubject<String, Never>("")
    @Published var textFieldText = ""
    
    func publisherSetUp(){
        currentTextPublisher
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .sink { [weak self] searchText in
                self?.fetchMovies(text:searchText)
            }.store(in: &cancellable)
        
        $textFieldText
            .debounce(for: .seconds(1), scheduler: DispatchQueue.main)
            .sink {[weak self] value in
                self?.fetchMovies(text: value)
            }.store(in: &cancellable)

    }
    
    func fetchMovies(text:String){
        if text.isEmpty{return}
        let trimWhitespace = text.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimWhitespace.isEmpty{return}
        guard let url = Api.apiUrl(searchText: "&s=\(trimWhitespace)&page=1").encodedString() else{return}
        print(url)
        apiService.getMovie(urlString: url)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion{
                case .finished:
                    print("finished api call")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: {[weak self] movies in
                    self?.arrMovies = movies
            }.store(in: &cancellable)

    }
    
}
