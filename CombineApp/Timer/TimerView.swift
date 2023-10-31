//
//  TimerView.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 31/10/23.
//

import SwiftUI

struct TimerView: View {
    @ObservedObject var timerViewModel = TimerViewModel()
    var body: some View {
        
        VStack{
            Text("\(timerViewModel.timerText)")
                .font(.title)
            
            TextField(text: $timerViewModel.textFieldValue,
                      prompt: Text("Enter email id")) {
                Rectangle()
                    .fill(.green)
                    .frame(width: 50)
            }
        }.padding()
    }
}

#Preview {
    TimerView()
}
