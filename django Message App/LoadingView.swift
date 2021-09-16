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
            Image("django").resizable().frame(width: 200, height: 80).cornerRadius(7).shadow(radius: 5)
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
