//
//  ViewHelper.swift
//  django Message App
//
//  Created by Hanlin Chen on 9/29/21.
//

import SwiftUI

struct InValidTextFieldModifer: ViewModifier {
    func body(content: Content) -> some View {
        return content.textFieldStyle(.roundedBorder).overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.red,lineWidth: 2 )).padding(.bottom, 3)
    }
}

struct ValidTextFieldModifer: ViewModifier {
    func body(content: Content) -> some View {
        return content.textFieldStyle(.roundedBorder).padding(.bottom, 3)
    }
}


extension UIApplication {
    func hideKeyBoard(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
