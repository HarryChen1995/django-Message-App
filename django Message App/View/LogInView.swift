//
//  LogInView.swift
//  LogInView
//
//  Created by Hanlin Chen on 9/14/21.
//

import SwiftUI


struct LogInView: View {
    @State var username = ""
    @State var password = ""
    @State var showSignUpSheet = false
    @EnvironmentObject var sessionManger:SessionManager
    var body: some View {
        ZStack{
            LinearGradient(colors: [Color.purple, Color.green , Color .blue], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea().onTapGesture {
                UIApplication.shared.hideKeyBoard()
            }
            VStack {
                Image("django").resizable().frame(width: 200, height: 80).cornerRadius(7).shadow(radius: 5).offset( y: -10)
                VStack{
                    
            
                    TextField("UserName", text: $username, prompt: Text("User Name")).customTextFieldModifer(error: sessionManger.error)
                  
                    SecureField("Password", text: $password, prompt: Text("Password")).customTextFieldModifer(error: sessionManger.error)
                
                    
                    Button(action: {
                        let _ = Task {
                            await sessionManger.signIn(username: username, password: password)
                        }
                    }, label: {
                        Text("Sign In").fontWeight(.bold).foregroundColor(.white).frame(maxWidth: .infinity, maxHeight: 25).padding(8).background(Color.blue).cornerRadius(10)
                    })
                    Divider()
                    Button(action: {
                        showSignUpSheet.toggle()
                    }, label: {
                        Text("Create New Account").fontWeight(.bold).foregroundColor(.white).frame(maxWidth: .infinity, maxHeight: 25).padding(8).background(Color.green).cornerRadius(10)
                    }).sheet(isPresented: $showSignUpSheet, content: SignUpView.init)
                    
                
                }.padding().background(.thinMaterial).cornerRadius(14).shadow(radius: 5).padding()
            }.padding()
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView().environmentObject(SessionManager()).previewInterfaceOrientation(.portrait)
    }
}

