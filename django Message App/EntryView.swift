//
//  EntryView.swift
//  EntryView
//
//  Created by Hanlin Chen on 9/14/21.
//

import SwiftUI

struct EntryView: View {
    @EnvironmentObject var sessionManger: SessionManager
    var body: some View {
        switch sessionManger.sessionStatus {
        case .loading:
            LoadingView()
        case .signedIn:
            ContentView()
        case .logIn:
            LogInView()
        default:
            LogInView()
        }
    }
}
