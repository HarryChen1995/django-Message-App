//
//  SessionAPI.swift
//  SessionAPI
//
//  Created by Hanlin Chen on 9/15/21.
//

import SwiftUI
let urlbase = "http://127.0.0.1:8000"

enum APIError:Error {
    case ForbiddenError
    case UnAuthorizedError
    case RefusedConnectionError
    case NotFoundError
    case InternalSeverError
}


extension HTTPURLResponse {
    @available(iOS 15.0.0, *)
    static func getAPIErrorFromResponse(response:URLResponse) -> APIError?{
        
        if let response = response as? HTTPURLResponse , response.statusCode ==  404 {
            return .NotFoundError
        }
        else if let response = response as? HTTPURLResponse , response.statusCode == 401 {
            return .UnAuthorizedError
        }
        else if let response = response as? HTTPURLResponse , response.statusCode == 403 {
            return .ForbiddenError
        }
        else if let response = response as? HTTPURLResponse , response.statusCode == 500 {
            return .InternalSeverError
        }
        
        return nil
    }
}


@MainActor
class DjangoAPI {
    
    static func getUserInfo(access_token:String) async -> Result<User?, APIError>{
        let url = URL(string: urlbase + "/api")
        var request = URLRequest(url: url!)
        request.addValue("Bearer " + access_token, forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        
        do {
            let (data, response) = try await URLSession.shared.data(for:request)
            
            if let apiError = HTTPURLResponse.getAPIErrorFromResponse(response: response) {
                return .failure(apiError)
            }
            let user = try? JSONDecoder().decode(User.self, from: data)
            return .success(user)
            
            
        }
        catch( let error) {
            print(error.localizedDescription)
        }
        
        return .failure(.RefusedConnectionError)
    }
    
    static func checkSignIn() async -> Bool {
        
        do {
            let url = URL(string: urlbase + "/auth/checklogin")
            let (_, response) = try await URLSession.shared.data(from: url!)
            if let _ = HTTPURLResponse.getAPIErrorFromResponse(response: response) {
                return false
            }
            return true
        }
        catch(let error){
            print(error.localizedDescription)
        }
        
        return false
        
    }
    static func signIn(username:String, password:String) async -> Result<Token, APIError>{
        let url = URL(string: urlbase + "/auth")
        var request = URLRequest(url: url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let  data = try! JSONSerialization.data(withJSONObject: ["username": username, "password": password], options: .prettyPrinted)
        request.httpBody = data
        do {
            let (data, response) = try await URLSession.shared.data(for:request)
            
            
            if let apiError = HTTPURLResponse.getAPIErrorFromResponse(response: response) {
                return .failure(apiError)
            }
            let token = try! JSONDecoder().decode(Token.self, from: data)
            UserDefaults.standard.set(username, forKey: "username")
            return .success(token)
            
            
        }
        catch( let error) {
            print(error.localizedDescription)
        }
        
        return .failure(.RefusedConnectionError)
        
    }
    
    
}
