//
//  django_Message_AppApp.swift
//  django Message App
//
//  Created by Hanlin Chen on 9/13/21.
//

import SwiftUI


@main
struct django_Message_AppApp: App {
    var body: some Scene {
        WindowGroup {
            EntryView().environmentObject(SessionManager())
            }
        }
}
