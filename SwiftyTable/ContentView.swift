//
//  ContentView.swift
//  SwiftyTable
//
//  Created by Aaron Barton on 7/10/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userData = UserData()
    @State private var sortOrder: [KeyPathComparator<User>] = [
        .init(\.name, order: .forward)
    ]
    @State private var selectedUser: User?

    var body: some View {
        VStack {
            Table(userData.users, sortOrder: $sortOrder) {
                TableColumn("Name", value: \.name)
                TableColumn("Email", value: \.email)
                TableColumn("Age") { user in
                    Text("\(user.age)")
                }
            }
            .onChange(of: sortOrder) { newOrder in
                // todo filtering sorting
            }
            .contextMenu {
                Button(action: {
                    // todo actions
                }) {
                    Text("Quick Action")
                }
            }
            .onTapGesture {
                // todo row click to show detail panel
            }
        }
        .sheet(item: $selectedUser) { user in
            DetailView(user: user)
        }
        .onAppear {
            userData.loadFromJSON()
        }
    }
}

struct DetailView: View {
    @State var user: User

    var body: some View {
        VStack {
            TextField("Name", text: $user.name)
            TextField("Email", text: $user.email)
            TextField("Age", value: $user.age, formatter: NumberFormatter())
        }
        .padding()
    }
}
