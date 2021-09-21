//
//  UserManager.swift
//  UserManager
//
//  Created by Hanlin Chen on 9/13/21.
//

import SwiftUI

enum SessionStatus {
    case signedIn
    case signedOut
    case signup
    case logIn
    case loading
}




@MainActor
class SessionManager: ObservableObject {
    
    @Published var sessionStatus: SessionStatus = .loading
    @Published var user:User?
    
    
    init(){
        
        if let _ = UserDefaults.standard.string(forKey: "username") {
            Task {
                let isSignedIn = await DjangoAPI.checkSignIn()
                if isSignedIn {
                    sessionStatus = .signedIn
                }
            }
        }
        sessionStatus = .logIn
        
    }
    
    func signIn(username:String , password:String) async {
        
        
        let result = await DjangoAPI.signIn(username: username, password: password)
        switch result {
        case .failure(_):
            sessionStatus = .logIn
        case .success(let token):
            UserDefaults.standard.set(username, forKey: "username")
            TokenKeyChainHelper.saveTokenIntoKeyChain(token: token.access, tokenType: .accessToken, username: username)
            TokenKeyChainHelper.saveTokenIntoKeyChain(token: token.refresh, tokenType: .refreshToken, username: username)
            sessionStatus = .signedIn
        }
        
    }
    
}

