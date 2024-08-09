//
//  ContentView.swift
//  2EPO
//
//  Created by found on 21/05/24.
//

import SwiftUI



struct ContentView: View {
    
    var body: some View {
        TabView {
            Group {
                TrilhaView()
                    .tabItem {
                        Label("Trilha", systemImage: "house")
                    }
                FonologiaView()
                    .tabItem {
                        Label("Fonologia", systemImage: "abc")
                    }
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(Color.menu, for: .tabBar)
        }
    }
}

#Preview {
    ContentView()
}
