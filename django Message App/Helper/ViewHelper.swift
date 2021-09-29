//
//  ViewHelper.swift
//  django Message App
//
//  Created by Hanlin Chen on 9/29/21.
//

import SwiftUI

extension View {
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}


extension View {
    func customTextFieldModifer(error: APIError?) -> some View{
        self.textFieldStyle(.roundedBorder).if(error != nil){
            view in
            view.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.red,lineWidth: 2 ))
        }.padding(.bottom, 3)
    }
}


extension UIApplication {
    func hideKeyBoard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
