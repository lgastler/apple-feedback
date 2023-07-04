//
//  SwiftDataEmptyCrashApp.swift
//  SwiftDataEmptyCrash
//
//  Created by Lennart Gastler on 04.07.23.
//

import SwiftUI

@main
struct SwiftDataEmptyCrashApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Contact.self)
    }
}
