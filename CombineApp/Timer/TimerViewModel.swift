//
//  TimerViewModel.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 31/10/23.
//

import Foundation
import Combine
class TimerViewModel: ObservableObject{
    @Published var timerText = 0
    @Published var textFieldValue = ""
    var cancellable = Set<AnyCancellable>()
    init(){
        let timer = Timer.publish(every: 1, on: .main, in: .default)
        let subscriber = timer.autoconnect().sink { [weak self]_ in
            self?.timerText += 1
        }
        subscriber.store(in: &cancellable)
        
        
        let textfieldValuePublisher = textFieldValue.publisher
        textfieldValuePublisher.map { char in
            print(char)
        }
        let textfieldSubscriber = textfieldValuePublisher.sink { text in
            print("\(text)")
        }
        textfieldSubscriber.store(in: &cancellable)

    }
    
}
