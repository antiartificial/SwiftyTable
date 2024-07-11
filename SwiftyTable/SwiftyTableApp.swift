//
//  SwiftyTableApp.swift
//  SwiftyTable
//
//  Created by Aaron Barton on 7/10/24.
//

import SwiftUI
import Foundation
import Combine

struct User: Identifiable, Decodable {
    let id: Int
    var name: String
    var email: String
    var age: Int
}

class UserData: ObservableObject {
    @Published var users: [User] = []

    func loadFromJSON() {
        if let url = Bundle.main.url(forResource: "users", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                self.users = try decoder.decode([User].self, from: data)
            } catch {
                print("Error loading JSON data: \(error)")
            }
        }
    }
}

@main
struct SwiftyTableApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
