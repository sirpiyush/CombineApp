//
//  SubjectView.swift
//  CombineApp
//
//  Created by Dipendra Dubey on 02/09/24.
//

import SwiftUI

struct SubjectView: View {
    @StateObject var viewModel = SubjectViewModel()
    var body: some View {
        VStack {
            Button(action: {
                viewModel.tapValue.send(viewModel.current)
            }, label: {
                Text("Tapped \(viewModel.current) time(s)")
            })
        }.onAppear{
            viewModel.initilSetUP()
        }
    }
}

#Preview {
    SubjectView()
}
