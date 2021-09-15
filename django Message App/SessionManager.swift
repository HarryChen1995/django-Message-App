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
}




@available(iOS 15.0.0, *)
@MainActor
class SessionManager: ObservableObject {
    
    @Published var sessionStatus: SessionStatus = .logIn
    @Published var user:User?
    

    init(){
       
        if let username = UserDefaults.standard.string(forKey: "username"),  let access_tocken =  TokenKeyChainHelper.retrieveToken(tokenType: .accessToken, username: username) {
            _ = Task {
                let url = URL(string: "http://127.0.0.1:8000/api")
                var request = URLRequest(url: url!)
                request.addValue("Bearer " + access_tocken, forHTTPHeaderField: "Authorization")
                request.httpMethod = "GET"
                
                do {
                    let (data, response) = try await URLSession.shared.data(for:request)
                    if let response = response as? HTTPURLResponse , response.statusCode == 200 {
                        user = try? JSONDecoder().decode(User.self, from: data)
                        sessionStatus = .signedIn
                    }
                }
                catch( let error) {
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func signIn(username:String , password:String) async {
        let url = URL(string: "http://127.0.0.1:8000/auth/")
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        guard let  data = try? JSONSerialization.data(withJSONObject: ["username": username, "password": password], options: .prettyPrinted) else {
            return
        }
        request.httpBody = data
        
        do {
            let (data, response) = try await URLSession.shared.data(for:request)
            if let response = response as? HTTPURLResponse , response.statusCode == 200 {
                guard let token = try? JSONDecoder().decode(Token.self, from: data) else {
                    return
                }
                UserDefaults.standard.set(username, forKey: "username")
                TokenKeyChainHelper.saveTokenIntoKeyChain(token: token.access, tokenType: .accessToken, username: username)
                TokenKeyChainHelper.saveTokenIntoKeyChain(token: token.refresh, tokenType: .refreshToken, username: username)
                sessionStatus = .signedIn
                
            }
        }
        catch( let error) {
            print(error.localizedDescription)
        }
        
    }
    
}

