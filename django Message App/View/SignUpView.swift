//
//  SignUpView.swift
//  django Message App
//
//  Created by Hanlin Chen on 9/29/21.
//

import SwiftUI

struct SignUpView: View {
    @State var username = ""
    @State var firstName = ""
    @State var lastName = ""
    @State var email = ""
    var body: some View {
        NavigationView{
            List{
            Section() {
                HStack{
                    Text("Username")
                    TextField("Username", text: $username, prompt: Text("Required"))
                }
                HStack{
                    Text("First Name")
                    TextField("Username", text: $firstName, prompt: Text("Required"))
                }
                HStack{
                    Text("Last Name")
                    TextField("Last Name", text: $lastName, prompt: Text("Required"))
                }
                HStack{
                    Text("Email")
                    TextField("Email", text: $email, prompt: Text("Required"))
                }
             }
                
                Section() {
                    Button(action: {}, label: {
                        Text("Create New Account")
                    }).disabled(true)
                 }
                
                
            
                
            }.navigationTitle("Create Account")
        }
     }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
