//
//  LoadingView.swift
//  LoadingView
//
//  Created by Hanlin Chen on 9/16/21.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color.purple, Color.green , Color .blue], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            ProgressView().progressViewStyle(.circular).tint(.white)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
