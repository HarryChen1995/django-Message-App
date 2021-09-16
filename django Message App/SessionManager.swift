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




@available(iOS 15.0.0, *)
@MainActor
class SessionManager: ObservableObject {
    
    @Published var sessionStatus: SessionStatus = .loading
    @Published var user:User?
    

    init(){
       
        if let username = UserDefaults.standard.string(forKey: "username"),  let access_token =  TokenKeyChainHelper.retrieveToken(tokenType: .accessToken, username: username) {
            Task {
                let result = await DjangoAPI.getUserInfo(access_token: access_token)
                
                switch result {
                case .failure(_):
                    sessionStatus = .logIn
                case .success(let session_user):
                    user  = session_user
                    sessionStatus = .signedIn
                }
            }
        }
        else {
            sessionStatus = .logIn
        }
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

