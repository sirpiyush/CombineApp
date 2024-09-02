//
//  SubjectViewModel.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 02/09/24.
//

import Foundation
import Combine

class SubjectViewModel: ObservableObject{
    var cancellable:Set<AnyCancellable> = []
    var tapValue = PassthroughSubject<Int,Never>()
    @Published var current = 1
    func initilSetUP(){
        tapValue
            .map{$0*2}
            .receive(on: DispatchQueue.main)
            .sink {[weak self] value in
                self?.current = value
            }
            .store(in: &cancellable)
    }
}
