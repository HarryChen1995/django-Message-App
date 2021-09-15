//
//  TokenKeyChainHelper.swift
//  TokenKeyChainHelper
//
//  Created by Hanlin Chen on 9/15/21.
//

import Foundation

import Security

enum TokenType {
    case accessToken
    case refreshToken
    
    func toString()->String{
        switch self {
        case .accessToken :
            return "access_token"
        case .refreshToken:
            return "refresh_token"
        }
    }
}
class TokenKeyChainHelper {
    

    static func saveTokenIntoKeyChain(token:String, tokenType:TokenType, username:String){
        let attributes: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username+"_"+tokenType.toString(),
            kSecValueData as String: token.data(using: .utf8)!,
        ]
        
        if SecItemAdd(attributes as CFDictionary, nil) == noErr {
            print("access token saved successfully in the keychain")
        } else {
            print("Something went wrong trying to save the access token in the keychain")
        }
    }



    static func retrieveToken(tokenType:TokenType, username:String)-> String?{
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username+"_"+tokenType.toString(),
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnAttributes as String: true,
            kSecReturnData as String: true,
        ]
        var item: CFTypeRef?

        // Check if user exists in the keychain
        if SecItemCopyMatching(query as CFDictionary, &item) == noErr {
            // Extract result
            if let existingItem = item as? [String: Any],
               let _  = existingItem[kSecAttrAccount as String] as? String,
               let tokenData = existingItem[kSecValueData as String] as? Data,
               let token = String(data: tokenData, encoding: .utf8)
            {
                return token
            }
        } else {
            print("Something went wrong trying to find the token in the keychain")
        }
        
        return nil
    }



    static func updateToken(token:String, tokenType:TokenType, username:String){

        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username+"_"+tokenType.toString(),
        ]

        // Set attributes for the new password
        let attributes: [String: Any] = [kSecValueData as String: token.data(using: .utf8)!]

        // Find user token and update
        if SecItemUpdate(query as CFDictionary, attributes as CFDictionary) == noErr {
            print("Token has changed")
        } else {
            print("Something went wrong trying to update the token")
        }
    }


    static func deleteToken(tokenType:TokenType, username:String){

        // Set query
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: username+"_"+tokenType.toString(),
        ]

        // Find user token and delete
        if SecItemDelete(query as CFDictionary) == noErr {
            print("Token removed successfully from the keychain")
        } else {
            print("Something went wrong trying to remove the token from the keychain")
        }
    }

    
}
